FROM quay.io/keycloak/keycloak:17.0.0@sha256:ab3b72a44813902fe44c9b927527f96096d4f9cbc4c881234b7b6bbc884d8dd8 as dev

FROM dev

ADD ./themes/mova /opt/jboss/keycloak/themes/mova