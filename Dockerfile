FROM respoke/asterisk:13.15

RUN rm /etc/asterisk/*
ADD etc/asterisk /etc/asterisk

ENV BROKER_PORT=19000
ENV AMI_SECRET=verboice
