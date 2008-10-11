from os import path
working_dir = path.dirname(path.abspath(path.dirname(__file__)))
#working_dir = path.abspath(path.dirname(__file__))
print working_dir

DEBUG = False
TEMPLATE_DEBUG = False

MANAGERS = ADMINS = (
    ('nubis', 'nubis@woobiz.com.ar'),
)

DATABASE_ENGINE = 'sqlite3'
DATABASE_NAME = working_dir+'\\mate_marote.sqlite'
print 'DATABASE_NAME:',DATABASE_NAME
DATABASE_USER = ''
DATABASE_PASSWORD = ''
DATABASE_HOST = ''
DATABASE_PORT = ''


TIME_ZONE = 'UTC'
LANGUAGE_CODE = 'es-ar'
SITE_ID = 1

MEDIA_ROOT = working_dir+'\\mate_marote\\static'

print 'MEDIA_ROOT:',MEDIA_ROOT
MEDIA_URL = '/static/'

PLANNING = {'levels_url': '/static/levels/planning/',
            'levels_dir': 'levels\\planning\\',
            'log_url': '/save_planning_game/',
            'create_url': '/create_planning_game/',
            'set_level_url': '/set_planning_level/',}

MEMORY = {'levels_url': '/static/levels/memory/',
          'levels_dir': 'levels\\memory\\',
          'log_url': '/save_memory_game/',
          'create_url': '/create_memory_game/',
          'set_level_url': '/set_memory_level/',}

# Make sure to use a trailing slash.
ADMIN_MEDIA_PREFIX = '/media/'
ADMIN_MEDIA_ROOT = working_dir+ '\\django\\contrib\\admin\\media'
print 'ADMIN_MEDIA_ROOT:',ADMIN_MEDIA_ROOT

# Make this unique, and don't share it with anybody.
SECRET_KEY = 'f309df7c72555faa9fcc7fdbfa7e79e5'

AUTHENTICATION_BACKENDS = (
    'django.contrib.auth.backends.ModelBackend',
)
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.load_template_source',
    'django.template.loaders.app_directories.load_template_source',
)
MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.middleware.doc.XViewMiddleware',
)
ROOT_URLCONF = 'mate_marote.urls'

TEMPLATE_DIRS = (working_dir+"\\mate_marote\\templates",
                 working_dir+"\\django\\contrib\\admin\\templates",)

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.admin',
    'mate_marote',
)

LOGIN_URL = '/index/'

SESSION_COOKIE_AGE = 60 * 60 * 24 #3600 seconds = 1 hour

TEMPLATE_CONTEXT_PROCESSORS = (
    'django.core.context_processors.auth',
    'django.core.context_processors.debug',
    'django.core.context_processors.media',
    'django.core.context_processors.request',
)

SITE_NAME = 'Mate Marote'
