(* A small collection of efficient operations on arrays of 3-dimensional,
 * float vectors. Of note is the special normalize function, which provides
 * even further advantage over mapping the typical normalize function with 
 * the map function provided by this library                                *)

type v3a

(* Create a new v3a based on function from an index to a vector *)
val tabulate : int -> (int -> float * float * float) -> v3a

(* Mutate each vector based on its index/value *)
val set : (int -> float * float * float) -> v3a -> unit
val map : (float * float * float -> float * float * float) -> v3a -> unit

(* Given a base case a right-associative function, reduces the array *)
val reduce : 'a -> ('a -> float * float * float -> 'a) -> v3a -> 'a

(* Special fast normalize *)
val normalize : v3a -> unit

(* Make a fresh copy of a v3a *)
val copy : v3a -> v3a
val copy_map : (float * float * float -> float * float * float) -> v3a -> v3a
