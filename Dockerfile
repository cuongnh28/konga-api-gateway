FROM kong/kong:2.7.0

ENV OIDC_PLUGIN_VERSION=1.2.3-2
ENV JWT_PLUGIN_VERSION=1.1.0-1

USER root
RUN apk update && apk add git unzip luarocks 
RUN luarocks install kong-oidc
RUN luarocks install kong-plugin-jwt-keycloak

RUN git clone --branch v1.2.3-2 https://github.com/revomatico/kong-oidc.git
WORKDIR /kong-oidc
RUN luarocks make

RUN luarocks pack kong-oidc ${OIDC_PLUGIN_VERSION} \
     && luarocks install kong-oidc-${OIDC_PLUGIN_VERSION}.all.rock

USER kong