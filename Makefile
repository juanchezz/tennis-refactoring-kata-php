.PHONY : main build-image build-container start test shell stop clean
main: build-image build-container

build-image:
	docker build -t tennis-game .

build-container:
	docker run -dt --name tennis-game -v .:/540/Boilerplate tennis-game
	docker exec tennis-game composer install

start:
	docker start tennis-game

test: start
	docker exec tennis-game ./vendor/bin/phpunit tests/$(target)

shell: start
	docker exec -it tennis-game /bin/bash

stop:
	docker stop tennis-game

clean: stop
	docker rm tennis-game
	rm -rf vendor
