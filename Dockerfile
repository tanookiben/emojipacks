FROM ruby:2.5.1

RUN mkdir -p /opt/emojis/run && \
    mkdir -p /opt/emojis/src

COPY scripts/download.rb /opt/emojis/run/

ENV DEBUG= \
    SOURCE=/opt/emojis/src \
    TOKEN=token

VOLUME /opt/emojis/src

WORKDIR /opt/emojis/run
