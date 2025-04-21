FROM golang:1.20 AS builder
WORKDIR /build
COPY ./ /build
RUN go get -d -v
RUN CGO_ENABLED=0 GOOS=linux go build

FROM scratch
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY --from=builder /build/s3bucket_exporter /bin/s3bucket_exporter
WORKDIR /tmp
ENTRYPOINT ["/bin/s3bucket_exporter"]
