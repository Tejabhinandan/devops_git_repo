FROM golang:1.21

WORKDIR /app

COPY main.go .

RUN go build -o app

EXPOSE 8080

CMD ["./app"]
