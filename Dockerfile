FROM quay.io/keycloak/keycloak:21.0.1@sha256:a6ed8daa6f1617f5c0c5484dcfe2d1febc17ec1d9146ecff97be296c3c314813 as keycloak

FROM keycloak as builder
ENV KC_DB=postgres
ENV KC_HTTP_RELATIVE_PATH=auth
ENV KC_HEALTH_ENABLED=true
RUN /opt/keycloak/bin/kc.sh build

FROM keycloak as dev
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
WORKDIR /opt/keycloak
CMD ["start-dev"]

FROM dev
ADD ./themes/mova /opt/keycloak/themes/mova
CMD ["--spi-login-protocol-openid-connect-legacy-logout-redirect-uri=true", "start"]