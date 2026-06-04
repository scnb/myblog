.PHONY: dev build clean new-post

dev:
	hugo server -D

build:
	hugo

clean:
	rm -rf public/ resources/

new-post:
	hugo new posts/$(POST_NAME)/index.md
