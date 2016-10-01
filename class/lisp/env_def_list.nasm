%include 'inc/func.inc'
%include 'class/class_vector.inc'
%include 'class/class_lisp.inc'

	def_function class/lisp/env_def_list
		;inputs
		;r0 = lisp object
		;r1 = vars list
		;r2 = vals list
		;outputs
		;r0 = lisp object
		;r1 = 0, vals list

		ptr this, vars, vals, symbol, value
		ulong len1, len2

		push_scope
		retire {r0, r1, r2}, {this, vars, vals}

		assign {0}, {value}
		if {vars->obj_vtable == @class/class_vector}
			if {vals->obj_vtable == @class/class_vector}
				static_call vector, get_length, {vars}, {len1}
				static_call vector, get_length, {vals}, {len2}
				if {len1 == len2}
					assign {0}, {len1}
					loop_while {len1 != len2}
						static_call vector, get_element, {vars, len1}, {symbol}
						static_call vector, get_element, {vals, len1}, {value}
						static_call lisp, env_def, {this, symbol, value}
						assign {len1 + 1}, {len1}
					loop_end
					assign {vals}, {value}
				else
					static_call lisp, error, {this, "(set vars vals): non matching lengths", vars}
				endif
			else
				static_call lisp, error, {this, "(set vars vals): vals not a list", vals}
			endif
		else
			static_call lisp, error, {this, "(set vars vals): vars not a list", vars}
		endif

		eval {this, value}, {r0, r1}
		pop_scope
		return

	def_function_end
