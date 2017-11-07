FROM golang:1.9-alpine3.6 as builder

MAINTAINER Julien Letrouit "julien.letrouit@shopify.com"

RUN apk update && apk upgrade && apk add git && \
    go get -u cloud.google.com/go/bigtable

ADD bigtable-emulator.go /go/bin/bigtable-emulator.go

RUN go build /go/bin/bigtable-emulator.go


FROM alpine:3.6

COPY --from=builder /go/bigtable-emulator /

ENTRYPOINT ["/bigtable-emulator"]

EXPOSE 9035
