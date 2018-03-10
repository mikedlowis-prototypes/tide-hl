.PHONY: all clean
.SUFFIXES: .ml .mll .cmx

all: tide-hl

clean:
	$(RM) tide-hl lex_*.ml *.cm* *.o

tide-hl: colormap.ml lex_cpp.ml lex_ruby.ml lex_ocaml.ml main.ml
	ocamlopt $(OLDFLAGS) $(INCS) -o $@ $^

.ml.cmx :
	ocamlopt -c -I . -o $@ $<

.mll.ml :
	ocamllex $(OLEXFLAGS) -o $@ $<

deps.mk: $(wildcard *.ml*)
	ocamldep -I . -all -one-line $^ > deps.mk
-include deps.mk

