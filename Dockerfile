# demonstrate "dlv debug", including build tags
FROM golang:1.15.8-alpine AS dev
RUN apk add --no-cache --update git
RUN git clone https://github.com/go-delve/delve && cd delve && go install github.com/go-delve/delve/cmd/dlv
WORKDIR /go/src/app
COPY main.go .
CMD [ "dlv", "--listen=:2345", "--headless", "--api-version=2", "--log", "--build-flags=-tags=mytag", "debug", "main.go", "--", "-multiplier", "2" ]

# demonstrate "dlv exec"
FROM dev as build
RUN CGO_ENABLED=0 go build -gcflags="-N -l" -tags mytag -o /usr/local/bin/experiment2 main.go
CMD [ "dlv", "--listen=:2345", "--headless", "--api-version=2", "--log", "exec", "/usr/local/bin/experiment2", "--", "-multiplier", "2" ]

# demonstrate "dlv exec" from an image without any source code
# in VSCode your launch configuration must use /go/src/app (see WORKDIR in dev stage) as "substitutePath.to" or "remotePath"
FROM alpine AS deploy
COPY --from=build /go/bin/dlv /usr/local/bin/dlv
COPY --from=build /usr/local/bin/experiment2 /usr/local/bin/experiment2
CMD [ "/usr/local/bin/dlv", "--listen=:2345", "--headless", "--api-version=2", "--log", "exec", "/usr/local/bin/experiment2", "--", "-multiplier", "2" ]
