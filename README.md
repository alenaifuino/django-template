# Django Starter Template

This is a [Django](http://www.djangoproject.com) starter project that you can use as the starting point to develop your own and deploy it on Cloud Platform like [Heroku](https://www.heroku.com/).

## Features

- [Red Hat UBI 8 with Python 3.9](https://catalog.redhat.com/software/containers/ubi8/python-39/6065b24eb92fbda3a4c65d8f?container-tabs=overview) Docker base image
- [Visual Studio Code](https://code.visualstudio.com/) Docker integration
- Development and Production Docker containers
- [Django 3.2](https://docs.djangoproject.com/en/3.2/) LTS
- Production Web Servers with [NGINX](https://www.nginx.com/) and [Gunicorn](https://gunicorn.org/)
- HTTPS local development with [django-extensions](https://github.com/django-extensions/django-extensions)
- Decoupled production, staging, test, and local settings with [python-decouple](https://github.com/henriquebastos/python-decouple/)
- Live reload server for local development with [django-livereload-server](https://github.com/tjwalch/django-livereload-server)
- Local debugging with [django-debug-toolbar](https://github.com/jazzband/django-debug-toolbar)

## Special files in this repository

Apart from the regular files created by Django (`webapp/*`, `manage.py`), this repository contains:

```
.certs/                  - OpenSSL certificates folder for HTTPS support
.devcontainer/           - Vistual Studio Code development configuration folder
├── devcontainer.json        - Development container configuration file
└── docker-compose.yml       - Docker compose file
└── Dockerfile               - Docker configuration file for development
├── requirements.dev.txt     - List of development dependencies
.html-template/           - Folder to store an HTMl template
.vscode/                  - Visual Studio Code configuration files
.static/                  - Static files folder: css, js, and images
.env                      - Environment variables file
.gitattributes
.gitignore
Dockerfile                - Docker configuration file for production
nginx.conf                - NGINX configuration file for production
requirements.txt          - List of production dependencies
start-server.sh           - Shell file that executes production services
```

## Warnings

Please be sure to read the following warnings and considerations before running this code on your local workstation, shared systems, or production environments.

### Database configuration

The sample application code and templates in this repository contain database connection settings and credentials that rely on being able to use SQlite.

## Local Development

This is a minimal Django 3.2 project. To run this project in your development machine, follow these steps:

1. Clone the starter template

```
$ git clone https://github.com/alenaifuino/flask-template.git <webapp_name>
```

2. Run Visual Studio Code inside the directory where you cloned the repo

```
$ cd <webapp_name>
$ code .
```

3. Press `CTRL` + `Shift` + `P` and select `Remote Containers: Open Folder in Container...`
4. Open your browser and go to https://127.0.0.1:8000, you will be greeted with a welcome page.

From this initial state you can:
* Create new Django apps
* Rename the Django project
* Update settings to suit your needs
* Install more Python libraries and add them to the `requirements.txt` or `.devcontainer/requirements.dev.txt` files

## Special environment variables

### SECRET_KEY

You should change  the value in the .env file. For security purposes, make sure to set this to a random string as documented [here](https://docs.djangoproject.com/en/3.2/ref/settings/#std:setting-SECRET_KEY).

### ALLOWED_HOSTS

You should set the value in the .env file. Default value is "localhost, 127.0.0.1".

### INTERNAL_IPS

You should set the value in the .env file. Default value is "127.0.0.1".

### DJANGO_SUPERUSER_EMAIL and DJANGO_SUPERUSER_PASSWORD

You should define their values as environment variables in the production environment. They will be used by the `start-server.sh` script to create the superuser for the admin interface.


## NGINX configuration

The `server_name` value should be updated with the public domain name for your web server.

## Data persistence

You can deploy this application without a configured database in your Cloud Platform project, in which case Django will use a temporary SQLite database that will live inside your application's container, and persist only until you redeploy your application.

After each deploy you get a fresh, empty, SQLite database. That is fine for a first contact with Django, but sooner or later you will want to persist your data across deployments.

To do that, you should add a properly configured database server or ask your Cloud Platform administrator to add one for you. Then update the settings file for staging and production to update the `DATABASES` variable to match your database settings. Database user and password should probably be defined as environment variables in your production container.

Redeploy your application to have your changes applied, and open the welcome page again to make sure your application is successfully connected to the database server.


## Looking for help

If you get stuck at some point, or think that this document needs further details or clarification, you can give feedback and look for help by filing an issue.


## License

The MIT License (MIT)

Copyright (c) 2015 Chris Kibble

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
