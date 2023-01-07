UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
    LINK_FLAGS := -fno-common -flat_namespace -bundle -undefined suppress
else
    LINK_FLAGS := -shared -fpic
endif

CFLAGS=-D_DEFAULT_SOURCE -fpic -std=c99 -Wall -Wextra -pedantic -Wno-unused-parameter  $(shell pkg-config --cflags glib-2.0) -c
LDFLAGS=$(shell pkg-config --libs glib-2.0) -lprofanity

all: CFLAGS += -DNDEBUG -g0 -O3
all: LDFLAGS += -s
all: clcleaner.so

debug: CFLAGS += -g3 -O0
debug: clcleaner.so

%.so:%.o
	$(CC) $(LINK_FLAGS) $(LDFLAGS) -o $@ $^

%.o:%.c
	$(CC) $(INCLUDE) $(CFLAGS) -o $@ $<

clean:
	$(RM) clcleaner.so

