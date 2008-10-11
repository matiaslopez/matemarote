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
                choice = [None, None, [], entry.value]
                response[1].append(choice)
                storing_moves = True
                
            if entry.type == 'mouseMove' and storing_moves:
                v = entry.value
                choice[2].append([v['stage_x'], v['stage_y'], entry.time-pictures_shown_time ])
                
            if entry.type == 'PICTURE_SELECTED':
                choice[0] = entry.value['picId']
                choice[1] = [entry.value['stage_x'], entry.value['stage_y']]
                storing_moves = False
                
            if entry.type == 'LEVEL_FINISH':
                response[0] = int(entry.value['won'])
            
        return game_log
    
class PlanningGame(Game):
    VIEW_LOG_URL = 'planning_log'
    DOWNLOAD_LOG_URL = 'parsed_planning_log'

    def __unicode__(self):
        return u'Juego de Estrategia %s' % self.id
    
    def parse_log(self):
        # log format:
        # LOG_FILE = [TRIAL_RESPONSE, TRIAL_RESPONSE, ...]
        # TRIAL_RESPONSE = [TRIAL, RESPONSE]
        # RESPONSE = [correct, move_count, [CHAR_DRAG, CHAR_DRAG, ...]]
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
                response = [None, 0, [], []]
                game_log.append( [trial, response] )
                
            if entry.type == 'PLANNING_CHARACTER_START_DRAG':
                dragging = True
                v = entry.value
                char_drag = [v['character'], v['house'], v['house'], entry.time-start_time, None, []]
                response[2].append(char_drag)
                
            if entry.type == 'mouseMove':
                v = entry.value
                m = [v['stage_x'], v['stage_y'], entry.time-start_time ] 
                if dragging:
                    char_drag[5].append(m)
                else:
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
