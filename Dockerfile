FROM quay.io/keycloak/keycloak:21.0.0@sha256:882db3cd70af78ebcf92113a9a14692bb0e0701badfd5c47ffcfa5ad5bbc0b53 as keycloak

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