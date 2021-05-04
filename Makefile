build-dev:
	docker build -f Dockerfile -t vscode-go-debug --target=dev .

build:
	docker build -f Dockerfile -t vscode-go-debug --target=build .

build-deploy:
	docker build -f Dockerfile -t vscode-go-debug --target=deploy .

run:
	docker run --rm -p 2345:2345 vscode-go-debug