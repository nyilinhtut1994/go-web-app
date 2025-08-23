FROM golang:1.22.5 as base

WORKDIR /app

COPY go.mod .

RUN go mod download #download dependencies that is mentioned in go.mod

COPY . .

RUN go build -o go-web-app .

FROM gcr.io/distroless/base

COPY --from=base /app/go-web-app .

COPY --from=base /app/static ./static

EXPOSE 8080

CMD ["./go-web-app"]
