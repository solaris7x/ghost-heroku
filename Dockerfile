FROM node:10-alpine as build
RUN apk add git
RUN git clone https://github.com/shawntoffel/ghost-imgur-https.git
RUN cd ghost-imgur-https && npm install

FROM ghost:3.12.0-alpine
COPY --from=build ghost-imgur-https content/adapters/storage/ghost-imgur
#COPY theme.patch /tmp/theme.patch
#WORKDIR $GHOST_INSTALL/content.orig/themes/casper
#RUN patch -p1 < /tmp/theme.patch && rm /tmp/theme.patch
COPY env.sh /usr/local/bin/env.sh
COPY docker-entrypoint.patch /tmp/docker-entrypoint.patch
WORKDIR /usr/local/bin
RUN patch -p1 < /tmp/docker-entrypoint.patch && rm /tmp/docker-entrypoint.patch

WORKDIR $GHOST_INSTALL

ENV storage__active ghost-imgur
ENV server__host 0.0.0.0
