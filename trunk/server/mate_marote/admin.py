from django.contrib import admin
from models import Player, MemoryGame, PlanningGame, StroopGame, LogEntry, MemoryGameFile, PlanningGameFile
from forms import MemoryGameFileForm

class PlayerAdmin(admin.ModelAdmin):
    pass
admin.site.register(Player, PlayerAdmin)

class GameAdmin(admin.ModelAdmin):
    list_display = ('__unicode__', 'player', 'created', 'log', 'parsed_log', 'entry_count')
    list_filter = ('created','player')
    ordering = ('created',)
    
admin.site.register(MemoryGame, GameAdmin)
admin.site.register(PlanningGame, GameAdmin)
admin.site.register(StroopGame, GameAdmin)

class GameFileAdmin(admin.ModelAdmin):
    list_display = ('file','created', 'is_default')
    
    def save_model(self, request, obj, form, change):
        if form.cleaned_data.get('is_default'):
            obj.__class__.objects.all().update(is_default=False)
        elif not obj.__class__.objects.filter(is_default=True).count():
            obj.is_default = True
        obj.save()
        
class MemoryGameFileAdmin(GameFileAdmin):
    form = MemoryGameFileForm

admin.site.register(MemoryGameFile, MemoryGameFileAdmin)
admin.site.register(PlanningGameFile, GameFileAdmin)

