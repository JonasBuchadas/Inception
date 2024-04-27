FROM debian:oldstable

RUN apt update && apt upgrade -y && apt install -y nginx openssl

RUN mkdir -p /etc/nginx/ssl /var/run/nginx

RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42/OU=student/CN=jocaetan.42.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d

EXPOSE 443

ENTRYPOINT [ "nginx" ]
CMD [ "-g", "daemon off;" ]
