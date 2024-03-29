"""
Caching framework.

This package defines set of cache backends that all conform to a simple API.
In a nutshell, a cache is a set of values -- which can be any object that
may be pickled -- identified by string keys.  For the complete API, see
the abstract BaseCache class in django.core.cache.backends.base.

Client code should not access a cache backend directly; instead it should
either use the "cache" variable made available here, or it should use the
get_cache() function made available here. get_cache() takes a backend URI
(e.g. "memcached://127.0.0.1:11211/") and returns an instance of a backend
cache class.

See docs/cache.txt for information on the public API.
"""

from cgi import parse_qsl
from django.conf import settings
from django.core.cache.backends.base import InvalidCacheBackendError

# Name for use in settings file --> name of module in "backends" directory.
# Any backend scheme that is not in this dictionary is treated as a Python
# import path to a custom backend.
BACKENDS = {
    'memcached': 'memcached',
    'locmem': 'locmem',
    'file': 'filebased',
    'db': 'db',
    'dummy': 'dummy',
}

def get_cache(backend_uri):
    if backend_uri.find(':') == -1:
        raise InvalidCacheBackendError, "Backend URI must start with scheme://"
    scheme, rest = backend_uri.split(':', 1)
    if not rest.startswith('//'):
        raise InvalidCacheBackendError, "Backend URI must start with scheme://"

    host = rest[2:]
    qpos = rest.find('?')
    if qpos != -1:
        params = dict(parse_qsl(rest[qpos+1:]))
        host = rest[2:qpos]
    else:
        params = {}
    if host.endswith('/'):
        host = host[:-1]

    if scheme in BACKENDS:
        module = __import__('django.core.cache.backends.%s' % BACKENDS[scheme], {}, {}, [''])
    else:
        module = __import__(scheme, {}, {}, [''])
    return getattr(module, 'CacheClass')(host, params)

cache = get_cache(settings.CACHE_BACKEND)
