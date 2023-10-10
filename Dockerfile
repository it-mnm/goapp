From golang:1.13-alpine as builder

RUN apk update && apk add git

WORKDIR /usr/src/app
COPY main.go .

#디렉토리 안의 go 파일들을 빌드해서 main이라는 바이너리 파일을 현재 디렉토리에 생성
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main .

#다단계 빌드 때문에 작성
FROM scratch

#앞에 builder라는 FROM절에서 /usr/src/app 디렉토리의 내용을 현재 디렉토리로 복사
COPY --from=builder /usr/src/app .

#main을 실행
CMD ["/main"]