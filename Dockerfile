FROM python:3.10-alpine
LABEL maintainer="londonappdeveloper.com"

ENV PYTHONUNBUFFERED 1

WORKDIR /app
EXPOSE 8000

COPY ./requirements.txt /requirements.txt
COPY ./app /app

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    # apk: alpine package manager
    apk add --update --no-cache postgresql-client && \ 
    apk add --update --no-cache --virtual .tmp-deps \
    build-base postgresql-dev musl-dev && \
    /py/bin/pip install -r /requirements.txt && \
    apk del .tmp-deps && \
    adduser --disabled-password --no-create-home app && \
    mkdir -p /vol/web/static && \
    mkdir -p /vol/web/mdeis && \
    chown -R app:app /vol && \
    chmod -R 755 /vol

ENV PATH="/py/bin:$PATH"

USER app





