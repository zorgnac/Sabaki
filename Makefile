# Cheat sheet around npm

.PHONY	: 1 all help

GRIP.sh	= $(shell bash -c "type -p grip")

-include user.mk
user.mk	:
	@echo "all	: help" > $@

ifeq (${CAPP.sh},)
#no-capp: dump usage information
help	:
	@awk -v FS='	' \
	'/^#(no-capp)?:/ { gsub(/^#(no-capp)?: */, "	"); M=M "\n" $$0; next } \
	M {print $$1 M; M=""}' ${MAKEFILE_LIST}
endif

.PHONY	: required watch run linux
#: install required modules
required	:
	npm install

#: watch changes and rebuild bundle accordingly
watch	:
	npm run watch

FILE	?=
#: run sabaki (on FILE=${FILE})
run	:
	npm start ${FILE}

#: make distribution for standalone run
linux	: 1
	npm run dist:linux

.PHONY	: README CHANGELOG
ifneq (${GRIP.sh},)
#: view README
README	:
	${GRIP.sh} -b README.md

#: view CHANGELOG
CHANGELOG	:
	${GRIP.sh} -b CHANGELOG.md
else
README	\
CHANGELOG	\
	:
	cat $@.md
endif
