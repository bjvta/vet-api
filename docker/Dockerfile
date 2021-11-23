FROM ruby:2.6.5-alpine3.11 as base

RUN apk add \
    --no-cache \
    --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
    # Docker tools
    gosu \
    tini

RUN apk add \
    --no-cache  \
    git \
    tzdata \
    build-base \
    bash

# Install node yarn
RUN apk add \
    --no-cache \
    nodejs \
    yarn \
    postgresql-dev \
    imagemagick

# Setup non-root user
RUN set -eux \
    \
    && addgroup -g 1000 app \
    && adduser -u 1000 -G app -H -D app \
    \
    && mkdir -p /app

ENV LANG="C.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_COLLATE="C" \
    GEM_HOME="/usr/local/bundle"

RUN bundle config build.nokogiri --use-system-librarie

WORKDIR "/app"

EXPOSE 8000

COPY entrypoint-base.sh /sbin/docker-entrypoint.sh

ENTRYPOINT ["tini", "--", "/sbin/docker-entrypoint.sh"]

FROM base as develop

COPY ./skel /etc/skel

RUN set -eux \
    && mkdir /home/app \
    && chown app:app -R /home/app \
    && gosu app cp -R /etc/skel/. /home/app/

VOLUME /home/app

COPY entrypoint-development.sh /sbin/docker-entrypoint.sh