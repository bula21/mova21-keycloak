FROM quay.io/keycloak/keycloak:18.0.0@sha256:7f80b2c243c738761bb8702c16b7f30da40426604f2c18a5767492917ca886dc as keycloak

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