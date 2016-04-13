FROM alpine:latest

MAINTAINER "Andy Nicholson <andrew@anicholson.net>"

RUN apk update
RUN apk add wget
RUN apk add go
RUN apk add make git

ENV IPFS_VERSION v0.4.0

ENV GOPATH /opt/go
ENV PATH $PATH:/usr/local/go/bin:$GOPATH/bin


RUN mkdir -p $GOPATH/src

WORKDIR $GOPATH/src

# Owing to complications in getting the exact version of a Go package

RUN git clone https://github.com/ipfs/go-ipfs.git

RUN mkdir -p ./github.com/ipfs

RUN mv go-ipfs ./github.com/ipfs/

WORKDIR ./github.com/ipfs/go-ipfs

RUN git checkout ${IPFS_VERSION}

RUN make toolkit_upgrade

RUN make install
