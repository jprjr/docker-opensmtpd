FROM jprjr/arch
MAINTAINER John Regan <john@jrjrtech.com>

RUN pacman -Syy >/dev/null 2>/dev/null && \
    pacman -S --noconfirm --quiet opensmtpd >/dev/null 2>/dev/null

ADD s6-1.1.3.2-musl-static.tar /

RUN mkdir -p /etc/s6/.s6-svscan && \
    ln -sf /bin/true /etc/s6/.s6-svscan/finish && \
    mkdir /etc/s6/opensmtpd && \
    ln -s /vin/true /etc/s6/opensmtpd/finish && \
    rm -f /etc/smtpd.conf && \
    mkdir -p /opt/opensmtpd.default

ADD conf/smtpd.conf /opt/opensmtpd.default/smtpd.conf
ADD opensmtpd.setup /etc/s6/opensmtpd/setup
ADD opensmtpd.run /etc/s6/opensmtpd/run

ENTRYPOINT ["/usr/bin/s6-svscan","/etc/s6"]
