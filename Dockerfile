# Python image for our Project Dockerfile: alpine
FROM python:3.7-alpine
MAINTAINER Pablo Peña

# From stackoverflow
# Setting PYTHONUNBUFFERED to a non empty value ensures that the python output is sent straight to terminal
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
# In order to be able to install psycopg2, we need to do:
# It uses the package manager that comes with our alpine
# APK, add and update the registry(postresql-client) before adding it without cache.
# best practices so that the container has the less footprint available
RUN apk add --update --no-cache postgresql-client
# Set up an alias for our dependencies in order to remove then later
RUN apk add --update --no-cache --virtual .tmp-build-deps \
		gcc libc-dev linux-headers postgresql-dev

RUN pip install -r /requirements.txt

RUN apk del .tmp-build-deps

# creates an empty folder
RUN mkdir /app
# and sets it as our default directory
WORKDIR /app
# then we move our local ./app folder to our image .app folder
COPY ./app /app

# Just for security reasons in order to avoid
# running it as a root user
RUN adduser -D user
USER user