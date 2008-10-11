from distutils.core import setup
import py2exe, os

setup(console=['mate_marote.py'],
      options={'py2exe':{'packages':['django',
                                     'simplejson',
                                     'email',
                                     'mate_marote',]}})
