import simplejson, csv
from cStringIO import StringIO
import csv
from json import json_encode
from django.conf import settings
from django.shortcuts import get_object_or_404, render_to_response
from django.http import HttpResponse, HttpResponseServerError, HttpResponseRedirect
from django.core.urlresolvers import reverse
from models import *
from datetime import datetime
import os
from os.path import join
from forms import GameSelectorForm

def json_response(**kargs):
    return HttpResponse(json_encode(kargs))

def player_list(request):
    players = [{'value':p.id, 'label':p.name} for p in Player.objects.all()]
    return json_response(players=players)

def select_player(request):
    try:
        player = Player.objects.get(id=request.POST.get('player_id'))
        request.session['player'] = player
        return json_response(status=200, 
                             memory_level=player.starting_memory_level,
                             planning_level=player.starting_planning_level)
    except Player.DoesNotExist:
        return json_response(status=404)

def get_or_create_player(request):
    player, x = Player.objects.get_or_create(name=request.POST['player_name'])
    request.session['player'] = player
    return json_response(status=200, player_id=player.id)
    
def player_selected(func):
    def decorator(request, *a, **kw):
        player = request.session.get('player')
        if not player:
            return HttpResponseServerError('Player has not been selected')
        return func(request, player, *a, **kw)
    
    return decorator

@player_selected
def create_game(request, player, game_class):
    """Creates a game and returns the game_id"""
    game = game_class.objects.create(player=player)
    return json_response(status=200, game_id=game.id)
    
@player_selected    
def save_game(request, player, game_class):
    """Saves a game of a certain type and stores its id on 
       the session object under id_session_key"""
    game = get_object_or_404(game_class, id=int(request.POST.get('game_id')))
    if game.player != player:
        return json_response(status=401)
    
    log = request.POST.get('log','')
    for line in StringIO(log.encode('utf-8')):
        ev = simplejson.JSONDecoder().decode(line)
        LogEntry.objects.create(game=game, type=ev['type'], time=ev['time'], data=str(ev['data']), order=ev['order'])
    
    return json_response(status=200)

@player_selected
def set_starting_level(request, player, level_attr):
    level = int(request.POST['level'])
    setattr(player, level_attr, level)
    player.save()
    return json_response(status=200)

@player_selected
def set_stroop_score(request, player):
    score = request.POST.get('score')
    setattr(player, 'stroop_score', score)
    player.save()
    return json_response(status=200)
    
def get_stroop_score(request, player):
    score = request.POST.get('score')
    setattr(player, 'stroop_score', score)
    player.save()
    return json_response(status=200)

def index(request, debug=False):
    memory = GameSelectorForm(MemoryGameFile, prefix='memory')
    planning = GameSelectorForm(PlanningGameFile, prefix='planning')
    return render_to_response('game_menu.html', {'memory_form':memory, 
                                                 'planning_form':planning, 
                                                 'debug': debug,})

def _show_game(request, swf_name, game_settings, form_prefix, game_file_class):
    form = GameSelectorForm(game_file_class, request.GET, prefix=form_prefix)
    if not form.is_valid():
        return HttpResponseRedirect(reverse('index'))

    return render_to_response('load_game.html',
                              {'choose_player_url': reverse('select_player'),
                               'player_list_url': reverse('list_players'),
                               'media_url':settings.MEDIA_URL,
                               'swf_name': swf_name,
                               'create_url': game_settings['create_url'],
                               'log_url': game_settings['log_url'],
                               'set_level_url': game_settings['set_level_url'],
                               'debug': int(form.cleaned_data['debug']),
                               'light': int(form.cleaned_data['light']),
                               'game_url': form.cleaned_data['gamefile'].file.url,})

def show_memory(request):
    return _show_game(request, 'memory', settings.MEMORY, 'memory', MemoryGameFile)

def show_planning(request):
    return _show_game(request, 'planning', settings.PLANNING, 'planning', PlanningGameFile)
    
def _game_log(request, game_id, game_class, template, reduced):
    game = get_object_or_404(game_class, id=game_id)
    log = game.log_entries.all()
    if reduced:
        log = log.exclude(type__in=["mouseDown","mouseMove"])
    log = log.order_by('order')
    return render_to_response(template, {'game':game, 'log':log})

def memory_log(request, game_id):
    return _game_log(request, game_id, MemoryGame, 'logs/memory.html', True)

def planning_log(request, game_id):
    return _game_log(request, game_id, PlanningGame, 'logs/planning.html', True)

def stroop_log(request, game_id):
    return _game_log(request, game_id, StroopGame, 'logs/stroop.html', True)

def full_memory_log(request, game_id):
    return _game_log(request, game_id, MemoryGame, 'logs/full_memory.html', False)

def full_planning_log(request, game_id):
    return _game_log(request, game_id, PlanningGame, 'logs/full_planning.html', False)

def full_stroop_log(request, game_id):
    return _game_log(request, game_id, StroopGame, 'logs/full_stroop.html', False)

def parsed_log(request, game_id, game_class):
    game = get_object_or_404(game_class, id=game_id)
    return HttpResponse(json_encode(game.parse_log()), content_type="text/plain")

def dummygame(request, swf):
    return render_to_response('dummygame.html', {'swf_name': settings.MEDIA_URL+swf})

def show_control(request):
    return render_to_response('control.html')
    
