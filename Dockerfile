FROM jlesage/baseimage-gui:ubuntu-22.04-v4.5.3 AS builder

RUN apt-get update && \ 
    apt-get install -y --no-install-recommends --no-install-suggests ca-certificates curl

RUN mkdir -p /grass

COPY startapp.sh /grass/startapp.sh
RUN chmod +x /grass/startapp.sh

COPY main-window-selection.jwmrc /grass/main-window-selection.jwmrc

ARG APP_URL=https://files.grass.io/file/grass-extension-upgrades/v5.5.4/Grass_5.5.4_amd64.deb
RUN curl -sS -L ${APP_URL} -o /grass/grass.deb


FROM jlesage/baseimage-gui:ubuntu-22.04-v4.5.3
LABEL org.opencontainers.image.authors="217heidai@gmail.com"

ENV KEEP_APP_RUNNING=1
# jlesage/baseimage-gui:ubuntu-22.04-v4.6 报错：Could not create surfaceless EGL display: EGL_NOT_INITIALIZED，待jlesage/baseimage-gui修复
# jlesage/baseimage-gui:ubuntu-22.04-v4.5 不支持 web auth
ENV SECURE_CONNECTION=1
ENV WEB_AUTHENTICATION=1
ENV WEB_AUTHENTICATION_USERNAME=grass
ENV WEB_AUTHENTICATION_PASSWORD=grass

RUN set-cont-env APP_NAME "Grass" && \
    set-cont-env APP_VERSION "5.5.4"

RUN apt-get update && \ 
    apt-get install -y --no-install-recommends --no-install-suggests ca-certificates libayatana-appindicator3-1 libwebkit2gtk-4.1-0 libegl-dev && \
    apt-get autoremove -y && \
    apt-get -y --purge autoremove && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /grass/ /grass/

RUN mkdir -p /etc/jwm && \
    mv /grass/main-window-selection.jwmrc /etc/jwm/main-window-selection.jwmrc && \
    mv /grass/startapp.sh /startapp.sh && \
    dpkg -i /grass/grass.deb && \
    rm -rf /grass
