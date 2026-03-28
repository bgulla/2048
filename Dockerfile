FROM cgr.dev/chainguard/nginx:latest

COPY index.html /usr/share/nginx/html/
COPY favicon.ico /usr/share/nginx/html/
COPY js/ /usr/share/nginx/html/js/
COPY style/ /usr/share/nginx/html/style/
COPY meta/ /usr/share/nginx/html/meta/
