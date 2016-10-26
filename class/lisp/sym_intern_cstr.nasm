%include 'inc/func.inc'
%include 'class/class_symbol.inc'
%include 'class/class_lisp.inc'

def_func class/lisp/sym_intern_cstr
	;inputs
	;r0 = lisp object
	;r1 = c string pointer
	;outputs
	;r0 = lisp object
	;r1 = interned symbol

	ptr this, symbol, intern

	push_scope
	retire {r0, r1}, {this, symbol}

	func_call symbol, create_from_cstr, {symbol}, {symbol}
	func_call lisp, sym_intern, {this, symbol}, {intern}
	func_call ref, deref, {symbol}

	eval {this, intern}, {r0, r1}
	pop_scope
	return

def_func_end
