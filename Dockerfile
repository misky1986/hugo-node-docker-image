# Use Alpine Linux as our base image so that we minimize the overall size our final container, and minimize the surface area of packages that could be out of date.
FROM alpine:3.10.3

LABEL description="A Docker container for building static sites with the Hugo static site generator and gulp as a development pipeline for handling assets."
LABEL maintainer="Michael Skydt"

# Hugo version

ENV HUGO_VERSION=0.59.0
# Downlaod link for hugo extended
ENV HUGO_DOWNLOAD_URL=https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz

RUN wget $HUGO_DOWNLOAD_URL && \
	tar -xzf hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz && \
	mv hugo /usr/bin/hugo && \
	rm hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz LICENSE README.md

RUN apk update && apk upgrade
RUN apk add --update --no-cache \
    bash \
    ca-certificates \
    curl \
    git \
    openssh-client \
    nodejs \
    nodejs-npm \
    python \
    py-pip \
    asciidoctor \
    libc6-compat \
    libstdc++

RUN pip install --upgrade pip
RUN pip install Pygments

EXPOSE 1313