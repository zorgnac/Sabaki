# Cheat sheet around npm

.PHONY	: 1 all help

help	:

# Developper's own makefile (list it in .git/info/exclude)
user.mk	:;
-include user.mk

# Viewer for *.md
# MD.bin        ?= xdg-open
# MD.opt        ?= 
MD.bin	?= $(shell which grip)
MD.opt	?= -b


ifeq (${HAS.help},)
#help: dump usage information
help	:
	@awk -v FS='	' \
	'/^#(help)?:/ { gsub(/^#(help)?: */, "	"); M=M "\n" $$0; next } \
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
ifneq (${MD.bin},)
MD	= ${MD.bin} ${MD.opt}
#: view README
README	:
	${MD} README.md

#: view CHANGELOG
CHANGELOG	:
	${MD} CHANGELOG.md
else
README	\
CHANGELOG	\
	:
	cat $@.md
endif
