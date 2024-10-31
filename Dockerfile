FROM jlesage/baseimage-gui:ubuntu-22.04-v4.5.3 AS builder

RUN apt-get update && \ 
    apt-get install -y ca-certificates curl

RUN mkdir -p /grass

COPY startapp.sh /grass/startapp.sh
RUN chmod +x /grass/startapp.sh

COPY main-window-selection.jwmrc /grass/main-window-selection.jwmrc

ARG APP_URL=https://files.getgrass.io/file/grass-extension-upgrades/ubuntu-22.04/grass_4.27.3_amd64.deb
RUN curl -sS -L ${APP_URL} -o /grass/grass.deb


FROM jlesage/baseimage-gui:ubuntu-22.04-v4.5.3
LABEL org.opencontainers.image.authors="217heidai@gmail.com"

#ENV LANG=en_US.UTF-8
#ENV ENABLE_CJK_FONT=1
ENV KEEP_APP_RUNNING=1

RUN set-cont-env APP_NAME "Grass"
RUN set-cont-env APP_VERSION "4.27.3"

RUN apt-get update && \ 
    apt-get install -y ca-certificates libayatana-appindicator3-1 libwebkit2gtk-4.1-0 libegl-dev && \
    apt-get auto-remove -y && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /grass/ /grass/

RUN mkdir -p /etc/jwm && \
    mv /grass/main-window-selection.jwmrc /etc/jwm/main-window-selection.jwmrc && \
    mv /grass/startapp.sh /startapp.sh && \
    dpkg -i /grass/grass.deb && \
    rm -rf /grass