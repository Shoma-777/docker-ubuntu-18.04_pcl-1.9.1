NAME=ubuntu-18.04_pcl-1.9.1
FULLNAME=m5182107/$(NAME)
VERSION=latest

build:
	docker build -t $(FULLNAME):$(VERSION) .

restart: stop start

start:
	docker run -itd \
		--name $(NAME) \
		$(FULLNAME):$(VERSION) bash

contener=`docker ps -a -q`
image=`docker images | awk '/^<none>/ { print $$3 }'`

clean:
	@if [ "$(image)" != "" ] ; then \
		docker rmi $(image); \
		fi
	@if [ "$(contener)" != "" ] ; then \
		docker rm $(contener); \
		fi

stop:
	docker rm -f $(NAME)

attach:
	docker exec -it $(NAME) /bin/bash

logs:
	docker logs $(NAME)

run:
	docker run -it $(FULLNAME):$(VERSION) /bin/bash

push:
	docker push $(FULLNAME):$(VERSION)
	