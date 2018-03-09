# Toolchain Configuration
#-------------------------------------------------------------------------------
OC     = ocamlopt
BINEXT = bin
OBJEXT = cmx
INCS   = -I .

# Target Definitions
#-------------------------------------------------------------------------------
.PHONY: all clean docs deps

all: tide-hl

tide-hl: colormap.ml lex_cpp.ml lex_ruby.ml lex_ocaml.ml main.ml
	ocamlopt $(OLDFLAGS) $(INCS) -o $@ $^

clean:
	$(RM) tide-hl *.cm* *.o *.a

deps: deps.mk
deps.mk: $(wildcard *.ml* lib/*.ml* tests/*.ml*)
	ocamldep -I . -all -one-line $^ > deps.mk
-include deps.mk

# Implicit Rule Definitions
#-------------------------------------------------------------------------------
.SUFFIXES: .c .o .ml .mli .mll .cmo .cmx .cmi .cma .cmxa .byte .bin
.ml.cmx :
	ocamlopt -c $(OFLAGS) $(INCS) -o $@ $<
.mli.cmi :
	$(OC) -c $(OFLAGS) $(INCS) -o $@ $<
.mll.ml :
	ocamllex $(OLEXFLAGS) -o $@ $<
