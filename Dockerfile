# FROM node:6
#  
# MAINTAINER Paapa Abdullah Morgan <paapaabdullahm@gmail.com>
#
# RUN apt-get update \
#     && npm install -g @angular/cli@1.1.0 \
#     # && echo 'Yes, do as I say!' | apt-get remove -y --purge --force-yes $BUILD_PACKAGES $(apt-mark # showauto) \
#     && rm -rf /var/lib/apt/lists/* && npm cache clear \
#     && sed -i -e "s/bin\/bash/bin\/sh/" /etc/passwd
# 
# 
# RUN groupadd --gid 2000 ng-data \
#     && useradd --uid 2000 --gid ng-data --shell /bin/bash --create-home ng-data
# 
# ENV HOME=/home/ng-data APP=app 
# 
# WORKDIR $HOME
# 
# RUN npm install -g @angular/cli
# 
# COPY *.json $HOME/$APP/
# 
# RUN chown -R ng-data:ng-data $HOME/*
# 
# USER ng-data
# 
# WORKDIR $HOME/$APP
# 
# RUN npm install && npm cache clean
# 
# EXPOSE 4200 49153
# CMD ["ng", "serve"]

FROM node:8.1.0-alpine

MAINTAINER Paapa Abdullah Morgan <paapaabdullahm@gmail.com>

RUN apk update \
    && apk add --update alpine-sdk \
    && npm install -g @angular/cli@1.1.0 \
    #&& ng set --global packageManager=yarn \
    && ng new my-app \
    && apk del alpine-sdk \
    && rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \
    && npm cache --force clear \
    && sed -i -e "s/bin\/bash/bin\/sh/" /etc/passwd

WORKDIR my-app
EXPOSE 4200 49153
CMD ["ng", "serve", "--host", "0.0.0.0"]
