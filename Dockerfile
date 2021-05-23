FROM buildkite/puppeteer:5.2.1

ENV LANG ja_JP.UTF-8

RUN apt-get update && \
    apt-get -y install locales fonts-ipafont fonts-ipaexfont vim curl && \
    echo "ja_JP UTF-8" > /etc/locale.gen && locale-gen

