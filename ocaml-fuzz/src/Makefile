all: Makefile.coq
	$(MAKE) -f $< $@

Makefile.coq: _CoqProject
	coq_makefile -f $< -o $@

clean:
	if [ -e Makefile.coq ]; then $(MAKE) -f Makefile.coq clean; fi
	$(RM) Makefile.coq* a.out
