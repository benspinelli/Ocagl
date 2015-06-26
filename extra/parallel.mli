(* Parmap provides parallel map and fold operations on lists and arrays *)
include Parmap

(* Number of cores to use *)
val cores : int ref

(* Default debugging functions *)
val dbg_print_init : int -> unit
val dbg_print_final : unit -> unit

(* Evaluate a function on two or three arguments in parallel *)
val par2 : ('a -> 'b) -> 'a -> 'a -> ('b * 'b)
val par3 : ('a -> 'b) -> 'a -> 'a -> 'a -> ('b * 'b * 'b)

(* Apply two or three deferred computations in parallel *)
val fnpar2 : (unit -> 'a) -> (unit -> 'a) -> ('a * 'a)
val fnpar3 : (unit -> 'a) -> (unit -> 'a) -> (unit -> 'a) -> ('a * 'a * 'a)
