bindir = /usr/local/bin
libdir = /usr/local/lib

obj = main.scm sirin.scm structures.scm

install:
	mkdir -p $(libdir)/sirin
	cp $(obj) $(libdir)/sirin
	cp dist.scm $(bindir)/sirin
	chmod +x $(bindir)/sirin
