# Python image for our Project Dockerfile: alpine
FROM python:3.7-alpine
MAINTAINER Pablo Peña

# From stackoverflow
# Setting PYTHONUNBUFFERED to a non empty value ensures that the python output is sent straight to terminal
ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
RUN pip install -r /requirements.txt

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