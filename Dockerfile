FROM golang:1.9-alpine3.6 as builder

MAINTAINER Julien Letrouit "julien.letrouit@shopify.com"

RUN apk update && apk upgrade && apk add git && \
    go get -u cloud.google.com/go/bigtable && \
    go get -u github.com/stretchr/testify

ADD *.go /go/bin/

ENV BIGTABLE_EMULATOR_HOST=localhost:9035

RUN go build /go/bin/bigtable-emulator.go && \
    /go/bigtable-emulator & \
    sleep 1 && \
    go test -v /go/bin/bigtable-emulator_test.go


FROM alpine:3.6

COPY --from=builder /go/bigtable-emulator /

ENTRYPOINT ["/bigtable-emulator"]

EXPOSE 9035
