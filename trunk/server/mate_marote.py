#!/usr/bin/env python
import django
import settings_sqlite
import webbrowser, time, sys, os
from django.core.servers.basehttp import run, AdminMediaHandler, WSGIServerException
from django.core.handlers.wsgi import WSGIHandler

class DummyFile(object):
    def write(*a, **kw): pass

if __name__ == "__main__":
    os.environ['DJANGO_SETTINGS_MODULE'] = 'settings_sqlite'
    port = 8712
    out = sys.stdout
    #importando admin modules
    import mate_marote.admin

    from django.conf import settings
    try:
        path = settings.ADMIN_MEDIA_ROOT
        handler = AdminMediaHandler(WSGIHandler(), path)
        print '''
Servidor de Mate Marote corriendo,
ingrese desde su navegador web a:
http://localhost:%s

Cierre esta ventana para finalizar
''' % port
        #sys.stderr = sys.stdout = DummyFile()
        webbrowser.open('http://localhost:%s' % port) #mmm
        run('0.0.0.0', port, handler)
    except WSGIServerException, e:
        # Use helpful error messages instead of ugly tracebacks.
        ERRORS = {
            13: "You don't have permission to access that port.",
            98: "That port is already in use.",
            99: "That IP address can't be assigned-to.",
        }
        try:
            error_text = ERRORS[e.args[0].args[0]]
            sys.stderr.write("Error: %s \n" % error_text)
        except (AttributeError, KeyError):
            error_text = str(e)
