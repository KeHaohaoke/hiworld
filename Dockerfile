FROM golang:alpine AS build-env
WORKDIR $GOPATH/src/github.com/KeHaohaoke/hiworld
COPY . .
RUN apk add git
RUN go get ./... && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o app cmd/hiworld/main.go

FROM alpine
WORKDIR /app
COPY --from=build-env /go/src/github.com/KeHaohaoke/hiworld/app /app/
CMD ["./app"]
USER 1000
EXPOSE 8080/tcp
