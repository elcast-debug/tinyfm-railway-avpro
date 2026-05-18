FROM php:8.2-fpm-alpine
RUN apk add --no-cache nginx supervisor ffmpeg curl bash \
 && mkdir -p /run/nginx /var/www/public/uploads /var/log/supervisor
WORKDIR /var/www
COPY public/ /var/www/public/
COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf
COPY scripts/optimize-mp4.sh /usr/local/bin/optimize-mp4.sh
RUN chmod +x /usr/local/bin/optimize-mp4.sh \
 && chown -R www-data:www-data /var/www/public/uploads
EXPOSE 8080
CMD ["/usr/bin/supervisord","-c","/etc/supervisord.conf"]
