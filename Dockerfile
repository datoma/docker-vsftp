FROM alpine
RUN apk --no-cache add vsftpd

COPY entrypoint.sh /bin/entrypoint.sh
COPY vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 21 21000-21010
VOLUME /ftp/ftp

ENTRYPOINT ["/bin/entrypoint.sh"]

