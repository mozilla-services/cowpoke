# cowpoke

A service for wrangling DNS

## Developing

### Installing

1. Install the requirements:

    1. [docker](https://docs.docker.com/get-docker/)
    1. [docker-compose](https://docs.docker.com/compose/install/)
    1. [Python 3.9](https://www.python.org/downloads/)
    1. [poetry](https://python-poetry.org/docs/#installation)

1. run `poetry install` to create a virtualenv and install python dependencies

1. run `SECRET_KEY=$(openssl rand -hex 32) docker-compose up --build`
   to build and run the service and database in docker containers

1. Alternatively, run `poetry shell` then `SECRET_KEY=$(openssl rand
   -hex 32) ./manage.py runserver` to run the service locally without
   a database

1. Visit http://localhost:8000/
