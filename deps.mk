colormap.cmo colormap.cmi : colormap.ml
colormap.cmx colormap.o colormap.cmi : colormap.ml
lex_cpp.cmo lex_cpp.cmi : colormap.cmi lex_cpp.ml
lex_cpp.cmx lex_cpp.o lex_cpp.cmi : colormap.cmi colormap.cmx lex_cpp.ml
lex_ocaml.cmo lex_ocaml.cmi : colormap.cmi lex_ocaml.ml
lex_ocaml.cmx lex_ocaml.o lex_ocaml.cmi : colormap.cmi colormap.cmx lex_ocaml.ml
lex_ruby.cmo lex_ruby.cmi : colormap.cmi lex_ruby.ml
lex_ruby.cmx lex_ruby.o lex_ruby.cmi : colormap.cmi colormap.cmx lex_ruby.ml
main.cmo main.cmi : lex_ruby.cmi lex_ocaml.cmi lex_cpp.cmi colormap.cmi main.ml
main.cmx main.o main.cmi : lex_ruby.cmi lex_ruby.cmx lex_ocaml.cmi lex_ocaml.cmx lex_cpp.cmi lex_cpp.cmx colormap.cmi colormap.cmx main.ml
