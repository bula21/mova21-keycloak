FROM quay.io/keycloak/keycloak:16.1.1@sha256:24175bfe68a40a56ec20849bd3fdac2f727ea0a851c24b29df663288a209d2f7 as dev

FROM dev

ADD ./themes/mova /opt/jboss/keycloak/themes/mova