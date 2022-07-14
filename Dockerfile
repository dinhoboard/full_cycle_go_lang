FROM golang:1.15.6-alpine AS builderGo
RUN apk update && apk add --no-cache
WORKDIR /src
COPY index.go .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-w -s" -a -installsuffix cgo -o index index.go
FROM scratch AS production
WORKDIR /app
COPY --from=builderGo /src/index .
CMD ["./index"]