FROM jboss/keycloak@sha256:b23994833c334540a9af2c9960431f5bd292e1007ad909414d20cd7ed0f01274 as dev

FROM dev

ADD ./themes/mova /opt/jboss/keycloak/themes/mova