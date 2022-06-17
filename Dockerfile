FROM quay.io/keycloak/keycloak:18.0.1@sha256:ea500b67924b04c9a262c91bc6fe6fd19d3382919a2b88056416937e29ab69b5 as keycloak

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