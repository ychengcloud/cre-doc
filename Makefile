# Docs
.PHONY: docs
docs:
	docsify serve ./



.PHONY: deps
deps:
	npm i docsify-cli -g