"""
Local development-specific settings include DEBUG mode, log level, and
activation of developer tools like django-debug-toolbar
"""

import socket

from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# Trick to have the django-debug-toolbar when developing within Docker
hostname, _, ips = socket.gethostbyname_ex(socket.gethostname())
INTERNAL_IPS += [".".join(ip.split(".")[:-1] + ["1"]) for ip in ips]

# Add django-extensions and django-debug-toolbar applications
INSTALLED_APPS.extend(("django_extensions", "debug_toolbar"))

# Add django-debug-toolbar support to the project
MIDDLEWARE.insert(0, "debug_toolbar.middleware.DebugToolbarMiddleware")

# Add livereload application before defining staticfiles
for count, value in enumerate(INSTALLED_APPS):
    if value == "django.contrib.staticfiles":
        INSTALLED_APPS.insert(count, "livereload")
        break

# Add livereload support to the project
MIDDLEWARE.append("livereload.middleware.LiveReloadScript")

# Database
# https://docs.djangoproject.com/en/3.2/ref/settings/#databases

DATABASES = {
    "default": {
        "ENGINE": "django.db.backends.sqlite3",
        "NAME": BASE_DIR / "db.local.sqlite3",
    }
}
