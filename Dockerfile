FROM quay.io/keycloak/keycloak:18.0.0@sha256:ba3be9ca05a7fb43aaf5518f4269bfdf96ef57c0d289b70396b6fa745a4e67b3 as keycloak

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
CMD ["start"]