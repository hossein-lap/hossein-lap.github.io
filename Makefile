all:
	@make build

tidy:
	@go mod tidy

build:
	@go build .
