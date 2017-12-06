NPM := $(shell command -v npm 2> /dev/null)
NODE := $(shell command -v node 2> /dev/null)

you_need_node = $(error You need to install nodejs. Try `brew install node`. See https://brew.sh for more info)

start: livereloadx
	sleep 1
	open http://localhost:35729

livereloadx: node_modules/livereloadx/bin/livereloadx.js
ifndef NODE
	$(call you_need_node)
endif
	$(NODE) node_modules/livereloadx/bin/livereloadx.js -s src/ &

node_modules/livereloadx/bin/livereloadx.js: node_modules/
	@echo "livereloadx installed!"

node_modules/: package.json
ifndef NPM
	$(call you_need_node)
endif
	$(NPM) install

clean:
	rm -rf node_modules
