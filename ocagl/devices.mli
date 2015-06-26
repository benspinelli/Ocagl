(* Binding functions for keyboard and mouse input *)

type button_t = Glut.button_t
type button_state_t = Glut.mouse_button_state_t

(* Creates a new keybinding. When the key corresponding to the given char
 * is pressed. The given function will be executed with the current
 * x and y locations of the mouse as arguments.                           *)
val bindKey : char -> (int -> int -> unit) -> unit
val resetKeys : unit -> unit

(* Creates a new mousebinding for the given button (left, right, middle)
 * and state (up, down). The function is executed with x and y locations. *)
val bindMouse : button_t -> button_state_t -> (int -> int -> unit) -> unit
val resetMouse : unit -> unit

(* Creates binding to the function that is executed if the mouse moves
 * while a button is pressed. The function is given, in order, the current
 * x and y locations of the mouse and the x and y deltas since the
 * function was last called.                                              *)
val bindMotion : (int -> int -> int -> int -> unit) -> unit
val resetMotion : unit -> unit
