from django.conf.urls.defaults import *
from django.conf import settings
from views import *
from models import PlanningGame, MemoryGame
from django.contrib import admin

admin.autodiscover()

urlpatterns = patterns('',
    #General
    url(r'^$', index, name="index"),
    url(r'^debug/$', index, {'debug':True}, name="index_debug"),
    url(r'^player_list/$', player_list, name='list_players'),
    url(r'^select_player/$', select_player, name='select_player'),
    url(r'^dummygame/(?P<swf>.*)/$', dummygame, name="dummygame"),

    #Memory
    url(r'^memory/$', show_memory, name='memory'),
    url(r'^create_memory_game/$', create_game, {'game_class': MemoryGame }),
    url(r'^save_memory_game/$', save_game, {'game_class': MemoryGame }),
    url(r'^set_memory_level/$', set_starting_level, {'level_attr': 'starting_memory_level' }),

    #Planning
    url(r'^planning/$', show_planning, name='planning'),
    url(r'^create_planning_game/$', create_game , {'game_class': PlanningGame }),
    url(r'^save_planning_game/$', save_game , {'game_class': PlanningGame }),
    url(r'^set_planning_level/$', set_starting_level, {'level_attr': 'starting_planning_level' }),
    
    #Admin
    url(r'^admin/(.*)', admin.site.root),
    url(r'^adm/memory_log/(?P<game_id>.*)/$', memory_log, name='memory_log'),
    url(r'^adm/full_memory_log/(?P<game_id>.*)/$', full_memory_log, name='full_memory_log'),
    url(r'^adm/parsed_memory_log/(?P<game_id>.*)/$', parsed_log, {'game_class': MemoryGame }, name='parsed_memory_log'),

    url(r'^adm/planning_log/(?P<game_id>.*)/$', planning_log, name='planning_log'),
    url(r'^adm/full_planning_log/(?P<game_id>.*)/$', full_planning_log, name='full_planning_log'),
    url(r'^adm/parsed_planning_log/(?P<game_id>.*)/$', parsed_log, {'game_class': PlanningGame }, name='parsed_planning_log'),
    
    #Static
    url(r'^static/(?P<path>.*)$', 'django.views.static.serve', {'document_root':settings.MEDIA_ROOT}),
    url(r'^media/(?P<path>.*)$', 'django.views.static.serve', {'document_root':settings.ADMIN_MEDIA_ROOT}),


)
