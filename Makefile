setup:
	@cd tools && \
	sh requirements.sh && \
	php setup.php;

up:
	@cd devops/docker && \
	docker-compose -f docker-compose.yml up

stop:
	@cd devops/docker && \
	docker-compose -f docker-compose.yml stop

restart:
	@cd devops/docker && \
	docker-compose -f docker-compose.yml restart

down:
	@cd devops/docker && \
	docker-compose -f docker-compose.yml down

