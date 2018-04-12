PROGRAM = tests/run-tests
MODULES_DIR = modules
OBJECT_FILES = sources/sqlite.o tests/main.o
CONSTANTS_FILE = sources/constants.f90
CONSTANTS_GENERATOR = sources/constants

.PHONY: build clean run setup

build: setup ${PROGRAM}

run: build
	@${PROGRAM}

sources/sqlite.o: sources/sqlite.f90 ${CONSTANTS_FILE}

${CONSTANTS_FILE}: ${CONSTANTS_GENERATOR}
	$^ >$@

${CONSTANTS_GENERATOR}: sources/constants.c
	${CC} -Wall $(shell pkg-config --cflags sqlite3) -o $@ $^

%.o: %.f90
	${CC} -std=f2008ts -Wall -J ${MODULES_DIR} -o $@ -c $<

${PROGRAM}: ${OBJECT_FILES}
	${CC} -o $@ $^ -lgfortran $(shell pkg-config --libs sqlite3)

setup: ${MODULES_DIR}

${MODULES_DIR}:
	mkdir -p $@

clean:
	rm -rf ${PROGRAM} ${OBJECT_FILES} ${MODULES_DIR}
	rm -rf ${CONSTANTS_GENERATOR} ${CONSTANTS_FILE}
