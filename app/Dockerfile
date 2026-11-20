
FROM nginx:1.27.5-alpine3.21-slim

ARG BUILD_SHA=unknown

LABEL maintainer="Isaac Ambi"
LABEL description="DevOps Command Hub - DevOps Intern Assessment"

COPY --chown=101:101 index.html /usr/share/nginx/html/index.html
COPY --chown=101:101 cheet.css commands.js cheet.js /usr/share/nginx/html/
COPY --chown=101:101 nginx.conf /etc/nginx/conf.d/default.conf

RUN sed -i '/^user[[:space:]]/d' /etc/nginx/nginx.conf \
    && sed -i 's|pid        /run/nginx.pid;|pid /tmp/nginx.pid;|' /etc/nginx/nginx.conf \
    && sed -i '/^http[[:space:]]*{/a\    client_body_temp_path /tmp/client_temp;\n    proxy_temp_path /tmp/proxy_temp;\n    fastcgi_temp_path /tmp/fastcgi_temp;\n    uwsgi_temp_path /tmp/uwsgi_temp;\n    scgi_temp_path /tmp/scgi_temp;' /etc/nginx/nginx.conf \
    && mkdir -p /tmp/client_temp /tmp/proxy_temp /tmp/fastcgi_temp /tmp/uwsgi_temp /tmp/scgi_temp \
    && chown -R 101:101 /tmp

ENV BUILD_SHA=${BUILD_SHA}

RUN sed -i "s/BUILD_SHA_PLACEHOLDER/${BUILD_SHA}/g" /usr/share/nginx/html/index.html

EXPOSE 8080

USER 101:101

HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD wget -q -O /dev/null http://127.0.0.1:8080/healthz || exit 1

CMD ["nginx", "-g", "daemon off;"]
