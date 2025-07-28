FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl && rm -rf /var/lib/apt/lists/*

# Utilisation du nom de domaine correct conforme au sujet
RUN mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -nodes -days 365 \
    -subj "/C=MA/ST=Sale/L=Sale/O=42 School/OU=Dev/CN=abouafso.42.fr" \
    -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/abouafso.key \
    -out /etc/nginx/ssl/abouafso.crt

RUN mkdir -p /var/www/html && \
    echo "<h1>Welcome to abouafso.42.fr</h1>" > /var/www/html/index.html

EXPOSE 443

# Copie la config nginx personnalisée
COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf

CMD ["nginx", "-g", "daemon off;"]