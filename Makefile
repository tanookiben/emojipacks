
#
# Default.
#

default: install

#
# Tasks.
#

# Install Emojipacks on your machine.
install: node_modules
				@npm link
				@echo
				@echo "\x1B[97m  emojipacks \x1B[90m·\x1B[39m Successfully installed Emojipack!"
				@echo "\x1B[97m             \x1B[90m·\x1B[39m Run \`emojipacks\` to get started."
				@echo

# Build Docker image for downloading emojis from a Slack organization
docker-build:
	docker build -t emojipacks:latest .

# Run Docker image to download emojis from a Slack organization
docker-run:
	docker run -d \
		-e DEBUG=$(DEBUG) \
		-e TOKEN=$(TOKEN) \
		-v `pwd`/src:/opt/emojis/src \
		emojipacks:latest ruby download.rb

# Install node modules with npm.
node_modules: package.json
	@npm install
	@touch node_modules

#
# Phonies.
#

.PHONY: clean
.PHONY: debug
.PHONY: run
.PHONY: server
.PHONY: docker-build
.PHONY: docker-run
