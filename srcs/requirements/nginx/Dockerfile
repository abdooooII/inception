FROM debian:bullseye

RUN apt update && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 \
    -subj "/C=MA/ST=Khribga/L=MIRIKAN/O=Abouafso Inc/OU=Dev/CN=abouafso.42.fr" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/abouafso.key \
    -out /etc/nginx/ssl/abouafso.crt

RUN mkdir -p /var/www/html && \
    echo "<h1>ABOUAFSOOOOOOO !!</h1>" >> /var/www/html/index.html

EXPOSE 443
#copy la config nginx personnalisée
COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf

CMD ["nginx", "-g", "daemon off;"]

