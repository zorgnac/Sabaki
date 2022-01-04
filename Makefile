
# Cheat sheet around npm

.PHONY	: 1 all

CAPP	= $(shell bash -c "type -p capp")
GRIP	= $(shell bash -c "type -p grip")

-include user.mk
user.mk	:
	@echo "all	: help" > $@

ifneq (${CAPP},)
include $(shell capp include help var)
else
#no-capp: dump usage information
help	:
	@awk -v FS='	' \
	'/^#(no-capp)?:/ { gsub(/^#(no-capp)?: */, "	"); M=M "\n" $$0; next } \
	M {print $$1 M; M=""}' ${MAKEFILE_LIST}
endif

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
ifneq (${GRIP},)
#: view README
README	:
	grip -b README.md

#: view CHANGELOG
CHANGELOG	:
	grip -b CHANGELOG.md
else
README	\
CHANGELOG	\
	:
	cat $@.md
endif
