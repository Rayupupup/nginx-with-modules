ARG NGINX_VERSION=1.20.1-alpine
FROM nginx:${NGINX_VERSION} AS builder
LABEL maintainer="liwenjun2049@gmail.com"

RUN apk add --no-cache --virtual .build-deps gcc libc-dev make openssl-dev pcre-dev zlib-dev linux-headers libxslt-dev gd-dev geoip-dev perl-dev libedit-dev mercurial bash alpine-sdk findutils

ARG MODULE_NAME=ngx_security_headers
ARG MODULE_VERSION=0.0.11
ARG BUILD_HOME=/usr/local

RUN cd ${BUILD_HOME} && \ 
curl -L "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -o nginx-${NGINX_VERSION}.tar.gz && \
curl -L "https://github.com/ray2049/${MODULE_NAME}/archive/${MODULE_VERSION}.tar.gz" -o ${MODULE_NAME}-${MODULE_VERSION}.tar.gz

RUN cd ${BUILD_HOME} && \ 
tar -zxvf nginx-${NGINX_VERSION}.tar.gz && \
tar -zxvf ${MODULE_NAME}-${MODULE_VERSION}.tar.gz

RUN cd ${BUILD_HOME}/nginx-${NGINX_VERSION} && \
./configure --with-compat --add-dynamic-module=${BUILD_HOME}/${MODULE_NAME}-${MODULE_VERSION} && \
make && make install 

# build images , add  ngx_security_headers module
ARG NGINX_VERSION=1.20.1-alpine
FROM nginx:${NGINX_VERSION}
LABEL maintainer="liwenjun2049@gmail.com"
#Copy ngx_http_security_headers_module module
COPY --from=builder /usr/local/nginx/modules/ngx_http_security_headers_module.so /etc/nginx/modules/ngx_http_security_headers_module.so