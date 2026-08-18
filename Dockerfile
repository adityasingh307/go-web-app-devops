FROM golang:1.22.5 AS builder    

WORKDIR /app

COPY go.mod .
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 go build -o web-app .


FROM scratch
COPY --from=builder /app/static ./static
COPY --from=builder /app/web-app .
EXPOSE 8080
CMD ["./web-app"] 