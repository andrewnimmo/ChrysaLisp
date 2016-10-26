%include 'inc/func.inc'
%include 'class/class_vector.inc'
%include 'class/class_error.inc'
%include 'class/class_lisp.inc'

def_func class/lisp/func_quote
	;inputs
	;r0 = lisp object
	;r1 = args
	;outputs
	;r0 = lisp object
	;r1 = value

	ptr this, args
	ulong length

	push_scope
	retire {r0, r1}, {this, args}

	devirt_call vector, get_length, {args}, {length}
	if {length == 1}
		devirt_call vector, ref_element, {args, 0}, {args}
	else
		func_call error, create, {"(quote arg) wrong numbers of args", args}, {args}
	endif

	eval {this, args}, {r0, r1}
	pop_scope
	return

def_func_end
