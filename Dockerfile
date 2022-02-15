FROM quay.io/keycloak/keycloak:17.0.0@sha256:ab3b72a44813902fe44c9b927527f96096d4f9cbc4c881234b7b6bbc884d8dd8 as keycloak

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