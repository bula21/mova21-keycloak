FROM quay.io/keycloak/keycloak:18.0.0@sha256:f5d1e8c0c1cde50ba1da82788af50be590e8fbf4d6e46198f9971c3bf94567f9 as keycloak

FROM keycloak as builder
ENV KC_DB=postgres
ENV KC_HTTP_RELATIVE_PATH=auth
RUN /opt/keycloak/bin/kc.sh build

FROM keycloak as dev
COPY --from=builder /opt/keycloak/lib/quarkus/ /opt/keycloak/lib/quarkus/
WORKDIR /opt/keycloak
CMD ["start-dev"]

FROM dev
ADD ./themes/mova /opt/keycloak/themes/mova
CMD ["start"]