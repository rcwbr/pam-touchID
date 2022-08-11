VERSION = 2
LIBRARY_NAME = pam_touchid.so
DESTINATION = /usr/local/lib/pam
TARGET = "$(shell uname -m)-apple-macosx$(shell sw_vers -productVersion)"

.PHONY: all

all: $(LIBRARY_NAME)

$(LIBRARY_NAME): touchid-pam-extension.swift
	swiftc touchid-pam-extension.swift -o $(LIBRARY_NAME) -target $(TARGET) -emit-library

install: $(LIBRARY_NAME)
	mkdir -p $(DESTINATION)
	install -b -o root -g wheel -m 444 $(LIBRARY_NAME) $(DESTINATION)/$(LIBRARY_NAME).$(VERSION)
