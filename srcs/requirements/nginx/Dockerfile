#Start from a debian image base
FROM debian:bullseye

#Update and Install package
RUN apt-get update
RUN apt-get install -y nginx openssl

#nginx SSL
RUN mkdir /etc/nginx/ssl

RUN openssl req -x509 -nodes -days 365 \
		-out /etc/nginx/ssl/jralph.crt \
		-keyout /etc/nginx/ssl/jralph.key \
		-subj "/C=FR/ST=Paris/L=Paris/O=42/OU=jralph/CN=jralph/"

COPY conf/nginx.conf /etc/nginx/nginx.conf

EXPOSE 443

#Start NGINX
CMD ["nginx", "-g", "daemon off;"]