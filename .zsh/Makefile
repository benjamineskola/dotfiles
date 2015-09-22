FUNCFILES := $(subst /.,.,$(addsuffix .zwc,$(dir $(wildcard */functions/*))))

all: $(FUNCFILES) functions.zwc
%.zwc: %/*
	zsh -c 'zcompile $@ $^'
