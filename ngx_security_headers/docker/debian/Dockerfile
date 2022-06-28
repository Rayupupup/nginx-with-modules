ARG NGINX_VERSION=1.20.1
FROM nginx:${NGINX_VERSION} AS builder
LABEL maintainer="liwenjun2049@gmail.com"
# Mirror
RUN sed -i 's#http://deb.debian.org#https://mirrors.ustc.edu.cn#g' /etc/apt/sources.list

RUN apt-get update &&  apt-get install --no-install-recommends --no-install-suggests -y \
  gnupg1 \
  ca-certificates  \
  gcc \
  libc-dev \
  make \
  openssl\
  curl \
  gnupg \
  wget \
  libpcre3 libpcre3-dev \
  libghc-zlib-dev

ARG MODULE_NAME=ngx_security_headers
ARG MODULE_VERSION=0.0.11
ARG BUILD_HOME=/usr/local

RUN cd ${BUILD_HOME} && \ 
wget "http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -O nginx-${NGINX_VERSION}.tar.gz && \
wget "https://github.com/ray2049/${MODULE_NAME}/archive/${MODULE_VERSION}.tar.gz" -O ${MODULE_NAME}-${MODULE_VERSION}.tar.gz

RUN cd ${BUILD_HOME} && \ 
tar -zxvf nginx-${NGINX_VERSION}.tar.gz && \
tar -zxvf ${MODULE_NAME}-${MODULE_VERSION}.tar.gz

RUN cd ${BUILD_HOME}/nginx-${NGINX_VERSION} && \
./configure --with-compat --add-dynamic-module=${BUILD_HOME}/${MODULE_NAME}-${MODULE_VERSION} && \
make && make install 

# build images , add  ngx_security_headers module
ARG NGINX_VERSION=1.20.1
FROM nginx:${NGINX_VERSION}
LABEL maintainer="liwenjun2049@gmail.com"
# Mirror
RUN sed -i 's#http://deb.debian.org#https://mirrors.ustc.edu.cn#g' /etc/apt/sources.list
#Copy ngx_http_security_headers_module module
COPY --from=builder /usr/local/nginx/modules/ngx_http_security_headers_module.so /etc/nginx/modules/ngx_http_security_headers_module.so