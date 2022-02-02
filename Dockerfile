FROM jboss/keycloak@sha256:333c263d31e1b56a0e13779e7c6166d591b19624f0b29465b03cd1827610ca2a as dev

FROM dev

ADD ./themes/mova /opt/jboss/keycloak/themes/mova