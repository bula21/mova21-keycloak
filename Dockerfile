FROM quay.io/keycloak/keycloak:19.0.2@sha256:e5f375089926aae34abab1b95937fb0721121d5b2016e89c89a4817f59c07e91 as keycloak

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