FROM quay.io/keycloak/keycloak:16.1.0@sha256:e7b6b1e3ae049a18498763410579b9619cd8c3277b3edc95844701af1cb42fc6 as dev

FROM dev

ADD ./themes/mova /opt/jboss/keycloak/themes/mova