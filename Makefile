build tmp/.built:
	docker-compose build
	docker-compose run web bundle 
	docker-compose run web yarn install --check-files
	docker-compose run web rails db:setup
	docker-compose stop
	touch tmp/.built

start: tmp/.built
	docker-compose up --exit-code-from=web

start-headless: tmp/.built
	docker-compose up -d
	@echo "Rails server launched, wait a moment for it to start. Visit http://localhost:3000"

stop:
	docker-compose stop

clean:
	docker-compose down
	docker-compose rm -s -f
	rm -f tmp/.built
