FROM ubuntu:latest
RUN apt-get -y update
COPY  test .
