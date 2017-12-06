BREW := $(shell command -v brew 2> /dev/null)
you_need_brew = $(error You need to install homebrew. See https://brew.sh for more info)
NODE=/usr/local/bin/node
NPM=/usr/local/bin/npm

start: livereloadx
	sleep 1
	open http://localhost:35729

livereloadx: node_modules/livereloadx/bin/livereloadx.js $(NODE)
	$(NODE) node_modules/livereloadx/bin/livereloadx.js -s src/ &

node_modules/livereloadx/bin/livereloadx.js: package-lock.json package.json $(NPM)
	$(NPM) install

$(NPM):
ifndef BREW
	$(call you_need_brew)
endif
	$(BREW) install node

$(NODE):
ifndef BREW
	$(call you_need_brew)
endif
	$(BREW) install node

clean:
	rm -rf node_modules
