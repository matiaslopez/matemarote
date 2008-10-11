from django import forms
import os
from os.path import join
from models import MemoryGameFile
from validators import validate_memory_game

class GameSelectorForm(forms.Form):
    def __init__(self, game_file_class, *a, **kw):
        super(GameSelectorForm, self).__init__(*a, **kw)
        try:
            self.default = game_file_class.objects.get(is_default = True)
        except game_file_class.DoesNotExist, e:
            raise NotImplementedError("NO HAY UN %s DEFAULT, ADMIN POR FAVOR DEFINALO" % game_file_class.__name__)
        
        choices = game_file_class.objects.all()
        self.fields['gamefile'] = forms.ModelChoiceField(choices, required=False)

    def clean_gamefile(self):
        if not self.cleaned_data['gamefile']:
            self.cleaned_data['gamefile'] = self.default
        return self.cleaned_data['gamefile']
    
    debug = forms.BooleanField(required=False)
    light = forms.BooleanField(required=False)
    
class MemoryGameFileForm(forms.ModelForm):
    class Meta:
        model = MemoryGameFile

    def clean_file(self):
        try:
            validate_memory_game(self.cleaned_data['file'].read())
            return self.cleaned_data['file']
        except Exception, e:
            raise forms.ValidationError(e)
