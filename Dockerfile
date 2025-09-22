# Build stage
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY main.go .

RUN CGO_ENABLED=0 GOOS=linux go build -o always-403 main.go

# Runtime stage
FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/always-403 .

EXPOSE 8080

CMD ["./always-403"]
