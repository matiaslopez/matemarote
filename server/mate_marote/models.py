import datetime
from cStringIO import StringIO
from django.db import models
from django.core.urlresolvers import reverse
from django.conf import settings

class BigIntegerField(models.IntegerField):
    def db_type(self):
        return 'bigint'

class Named(object):
    def __unicode__(self):
        return self.name

class GameFile(models.Model):
    created = models.DateTimeField(default=datetime.datetime.now)
    is_default = models.BooleanField(default=False)
    
    def __unicode__(self):
        return unicode(self.file)
    
    class Meta:
        abstract = True
    
class PlanningGameFile(GameFile):
    file = models.FileField(upload_to=settings.PLANNING['levels_dir'])
  
class MemoryGameFile(GameFile):
    file = models.FileField(upload_to=settings.MEMORY['levels_dir'])  

class Player(models.Model, Named):
    name = models.CharField(max_length=255)
    created = models.DateTimeField(default=datetime.datetime.now)
    starting_memory_level = models.IntegerField(null=True)
    starting_planning_level = models.IntegerField(null=True)

class LogEntry(models.Model):
    game = models.ForeignKey('Game', related_name='log_entries')
    type = models.CharField(max_length=100)
    time = BigIntegerField()
    order = models.IntegerField()
    data = models.TextField()
    
    @property
    def value(self):
        return eval(self.data)
    
    @property
    def pretty_data(self):
        from pprint import pformat
        return pformat(eval(self.data))
    
class Game(models.Model):
    VIEW_LOG_URL = ''
    DOWNLOAD_LOG_URL = ''
    player = models.ForeignKey(Player)
    created = models.DateTimeField(default=datetime.datetime.now)
    started = BigIntegerField(null=True)
    log_stored = models.DateTimeField(null=True)
    
    def log(self):
        return '<a href="%s">ver</a>' % reverse(self.VIEW_LOG_URL, args=[self.id])
    log.allow_tags = True
    
    def parsed_log(self):
        return '<a href="%s">bajar</a>' % reverse(self.DOWNLOAD_LOG_URL, args=[self.id])
    parsed_log.allow_tags = True
    
    def entry_count(self):
        return self.log_entries.all().count()
    
    def started_date(self):
        if self.started:
            return datetime.datetime.fromtimestamp(self.started/1000)

class MemoryGame(Game):
    VIEW_LOG_URL = 'memory_log'
    DOWNLOAD_LOG_URL = 'parsed_memory_log'
    
    def __unicode__(self):
        return u'Juego de Memoria %s' % self.id
    
    def as_matlab(self):
        from numpy import dtype,uint,array,ndarray,double
        from math import pi
        list2Arr = lambda x: array(tuple(x))
        none2PI = lambda x: x == None and pi or bool(x)

        TRIAL_TYPE = dtype([('nivel',uint),
                            ('agrup',uint),
                            ('nfichas',uint),
                            ('fichas',ndarray),])
                            #aca adentro falta DATA
        TRAYECTORIA = dtype([('trayectoria', ndarray)])
        RESPONSE_TYPE = dtype([('correct',uint),
                               ('nchoices',uint),
                               ('nficha',ndarray),
                               ('RTS',ndarray),
                               ('trayectoria',TRAYECTORIA),
                               ('posicionfichas',ndarray),])
        trials = []
        responses = []
        for t,r in self.parse_log():
            trials.append(array((t[0], t[1], len(t[2]), list2Arr(t[2])), dtype=TRIAL_TYPE))
            
            nfichas = []
            trayectorias = []
            response_times = []
            posiciones = []
            for choice in r[1]:
                nfichas.append(none2PI(choice[0]))
                trayectorias.append(array((choice[2],), dtype=TRAYECTORIA))
                p = [choice[3]]
                posiciones.append(p)
                response_times.append(choice[2][-1][-1])#time is last item in last mouse record
            
            responses.append(array(( none2PI(r[0]),
                                     len(r[1]),
                                     list2Arr(nfichas),
                                     list2Arr(response_times),
                                     list2Arr(trayectorias),
                                     list2Arr(posiciones))))
        return array(trials), array(responses)

#function [TRIALS RESPONSE] = parse_log_memory(DATA);
#
#for i=1:length(DATA{1})
#   TRIALS{i}.data=DATA{1}{i};
#   TRIALS{i}.nivel=cell2mat(DATA{1}{i}{1}(1));
#   TRIALS{i}.agrup=cell2mat(DATA{1}{i}{1}(2));
#   TRIALS{i}.nfichas=length(DATA{1}{i}{1}{3});
#   TRIALS{i}.fichas=[];
#   for nf=1:TRIALS{i}.nfichas
#       TRIALS{i}.fichas=[TRIALS{i}.fichas;cell2mat(DATA{1}{i}{1}{3}{nf})];
#   end
#
#   RESPONSE{i}.correct=DATA{1}{i}{2}{1};
#   RESPONSE{i}.nchoices=length(DATA{1}{i}{2}{2});
#   RESPONSE{i}.nficha=[];
#   RESPONSE{i}.RTS=[];
#   for nc=1:RESPONSE{i}.nchoices       
#       RESPONSE{i}.trayectoria{nc}=[];
#       RESPONSE{i}.nficha=[RESPONSE{i}.nficha,DATA{1}{i}{2}{2}{nc}{1}];
#       for nsamp=1:length(DATA{1}{i}{2}{2}{nc}{3});
#           RESPONSE{i}.trayectoria{nc}=[RESPONSE{i}.trayectoria{nc}; cell2mat(DATA{1}{i}{2}{2}{nc}{3}{nsamp})]
#       end
#       RESPONSE{i}.posicionfichas{nc}=[];
#       for nf=1:length(DATA{1}{i}{2}{2}{nc}{4})
#           RESPONSE{i}.posicionfichas{nc}=[RESPONSE{i}.posicionfichas{nc};cell2mat(DATA{1}{i}{2}{2}{nc}{4}{nf})];
#       end
#        RESPONSE{i}.RTS=[RESPONSE{i}.RTS,RESPONSE{i}.trayectoria{nc}(end,3)];
#   end
#end
    def parse_log(self):
        '''
        Log Format :
             card_pos = [card_x,card_y]
             mousemove = [x,y,t] # t es relativo a pictures_shown
             last_mouse = [x,y]
             choice = [num_ficha, last_mouse, [mousemove, ...], [card_pos, ...]]
             response = [correct, [choice, ...]]
             trial_response = [trial, response]
             game_log = [trial_response, ...]
        '''
        game_log = []
        game_data = None
        storing_moves = False
        last_mouse_record = None
        for entry in self.log_entries.order_by('order'):
            if entry.type == 'GAME_STARTED':
                game_data = entry.value
                start_time = entry.time
                
            if entry.type == 'TRIAL_STARTED':
                trial = game_data[4][entry.value]
                response = [None, []]
                game_log.append([trial, response])
                
            if entry.type == 'PICTURES_SHOWN':
                pictures_shown_time = entry.time
                choice = [None, None, None, entry.value]
                response[1].append(choice)
                storing_moves = True
                
            if entry.type == 'mouseMove':
                last_mouse_record = entry
                if storing_moves:
                    last_mouse_record = entry
                    v = entry.value
                    choice[2] = choice[2] or [] #initialize trajectory
                    choice[2].append(self.mousemove(entry,pictures_shown_time))
                
            if entry.type == 'PICTURE_SELECTED':
                choice[0] = entry.value['picId']
                choice[1] = [entry.value['stage_x'], entry.value['stage_y']]
                if not choice[2]: #Put something in trajectory if empty
                    choice[2] = [self.mousemove(e,pictures_shown_time)
                                      for e in (last_mouse_record, entry)]
                storing_moves = False
                
            if entry.type == 'LEVEL_FINISH':
                response[0] = int(entry.value['won'])
            
        return game_log
    
    def mousemove(self, entry, start_time):
        v = entry.value
        return [v['stage_x'], v['stage_y'], entry.time-start_time]
    
class PlanningGame(Game):
    VIEW_LOG_URL = 'planning_log'
    DOWNLOAD_LOG_URL = 'parsed_planning_log'

    def __unicode__(self):
        return u'Juego de Estrategia %s' % self.id
    
    def parse_log(self):
        # log format:
        # LOG_FILE = [TRIAL_RESPONSE, TRIAL_RESPONSE, ...]
        # TRIAL_RESPONSE = [TRIAL, RESPONSE]
        # RESPONSE = [correct, move_count, [CHAR_DRAG, CHAR_DRAG, ...], [WANDERING_MOUSE_MOVE, ...]]
        # CHAR_DRAG = [char_id, from, to, starttime, endtime,[MOUSE_MOVE, MOUSE_MOVE, ...]]
        # MOUSE_MOVE = [x,y,time]
        
        game_log = []
        game_data = None
        start_time = None
        dragging = False
        
        for entry in self.log_entries.order_by('order'):
            if entry.type == 'GAME_STARTED':
                game_data = entry.value
                start_time = entry.time
                
            if entry.type == 'TRIAL_STARTED':
                trial = game_data[4][entry.value]
                response = [None, 0, None, None]
                game_log.append( [trial, response] )
                
            if entry.type == 'PLANNING_CHARACTER_START_DRAG':
                dragging = True
                v = entry.value
                char_drag = [v['character'], v['house'], v['house'], entry.time-start_time, None, None]
                response[2] = response[2] or []
                response[2].append(char_drag)
                
            if entry.type == 'mouseMove':
                v = entry.value
                m = [v['stage_x'], v['stage_y'], entry.time-start_time ] 
                if dragging:
                    char_drag[5] = char_drag[5] or []
                    char_drag[5].append(m)
                else:
                    response[3] = response[3] or []
                    response[3].append(m)
            
            if entry.type == 'PLANNING_CHARACTER_MOVED':
                response[1] += 1
                char_drag[2] = entry.value['house']
                char_drag[4] = entry.time - start_time
            
            if entry.type == 'PLANNING_CHARACTER_DROPPED':
                dragging = False
            
            if entry.type == 'TRIAL_ENDED':
                response[0] = int(entry.value['won'])
        return game_log

class StroopGame(Game):
    VIEW_LOG_URL = 'stroop_log'
    DOWNLOAD_LOG_URL = 'parsed_stroop_log'
    
    def parse_log(self):
        return []
    def __unicode__(self):
        return u'Juego de Stroop %s' % self.id
