%include 'inc/func.inc'
%include 'class/class_boxed_ptr.inc'
%include 'class/class_lisp.inc'

	def_function class/lisp/built_in_func
		;inputs
		;r0 = lisp object
		;r1 = symbol
		;r2 = function pointer
		;outputs
		;r0 = lisp object

		ptr this, symbol, func_ptr, func

		push_scope
		retire {r0, r1, r2}, {this, symbol, func_ptr}

		static_call boxed_ptr, create, {}, {func}
		static_call boxed_ptr, set_value, {func, func_ptr}
		static_call lisp, env_def, {this, symbol, func}
		static_call boxed_ptr, deref, {func}

		eval {this}, {r0}
		pop_scope
		return

	def_function_end
