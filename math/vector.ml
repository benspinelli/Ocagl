(* A simple vector library. Dimension constraints are enforced during type   
 * checking, as array types generated from different parameter modules will  
 * have externally distinct array types. The exception is nth, which may     
 * raise an "index out of bounds" exception, so must be checked
 *)

module type PARAMS =
sig
  val dimension : int
end

module type VECTOR =
sig
  type elem
  type vector
  
  val dim : int
  
  val zero : vector          (* vector of all zeros *)
  val ones : vector          (* vector of all ones *)
  val unitX : vector option  (* unit vector in x direction *)
  val unitY : vector option  (* unit vector in y direction *)
  val unitZ : vector option  (* unit vector in z direction *)
  
  val of_list : elem list -> vector
  val to_list : vector -> elem list
  
  (* Arithmetic on Vectors *)
  
  (* Functions returning unit mutate the first argument.  *
   * Functions returning vectors do not mutate arguments. *)
  val ( ++ ) : vector -> vector -> vector
  val ( += ) : vector -> vector -> unit
  
  val ( -- ) : vector -> vector -> vector
  val ( -= ) : vector -> vector -> unit
  
  val ( ** ) : vector -> elem -> vector
  val ( *= ) : vector -> elem -> unit
  
  val ( // ) : vector -> elem -> vector
  val ( /= ) : vector -> elem -> unit
  
  val ( == ) : vector -> vector -> bool
  val ( != ) : vector -> vector -> bool
  
  (* Vector operations on vectors *)
  val dot : vector -> vector -> elem
  val cross : vector -> vector -> vector
  
  val length : vector -> elem
  val sq_length : vector -> elem
  
  val distance : vector -> vector -> elem
  val sq_distance : vector -> vector -> elem
  
  val normal : vector -> vector
  val normalize : vector -> unit
  
  val nth : int -> vector -> elem
  val x : vector -> elem
  val y : vector -> elem
  val z : vector -> elem

  (* Make a fresh copy of a vector *)
  val copy : vector -> vector
end

module Make(P : PARAMS) : VECTOR =
struct
  module A = Array

  type elem = float
  type vector = elem array

  let dim = P.dimension

  let zero = A.make dim 0.
  let ones = A.make dim 1.
  let unitX = if dim > 0 then let a = A.make dim 0. in a.(0) <- 1.; 
              Some a else None
  let unitY = if dim > 1 then let a = A.make dim 0. in a.(1) <- 1.; 
              Some a else None
  let unitZ = if dim > 2 then let a = A.make dim 0. in a.(2) <- 1.; 
              Some a else None
  
  let of_list v = assert(List.length v = dim); A.of_list v
  let to_list = A.to_list
  
  (* Arithmetic on Vectors *)
  let ( ++ ) u v = A.init dim (fun i -> u.(i) +. v.(i))
  let ( += ) u v = A.iteri (fun i x -> u.(i) <- u.(i) +. x) v
  
  let ( -- ) u v = A.init dim (fun i -> u.(i) -. v.(i))
  let ( -= ) u v = A.iteri (fun i x -> u.(i) <- u.(i) -. x) v
  
  let ( ** ) v e = A.init dim (fun i -> v.(i) *. e)
  let ( *= ) v e = A.iteri (fun i x -> v.(i) <- x *. e) v
  
  let ( // ) v e = A.init dim (fun i -> v.(i) /. e)
  let ( /= ) v e = A.iteri (fun i x -> v.(i) <- x /. e) v
  
  let ( == ) u v = A.fold_left (fun a b -> a && b) true 
                   (A.init dim (fun i -> u.(i) = v.(i)))
  let ( != ) u v = not (u == v)
  
  (* Vector operations on vectors *)
  let dot u v = A.fold_left (+.) 0.
                (A.init dim (fun i -> u.(i) *. v.(i)))
  let cross = if dim <> 3 
      then fun u v -> raise (Failure "Bad Dimension for cross")
      else fun u v -> raise (Failure "unimplemented")
  
  let sq_length v = dot v v
  let length v = sqrt (sq_length v)
  
  let sq_distance u v = let d = (u -- v) in dot d d
  let distance u v = sqrt (sq_distance u v)
  
  let normal v = v // (length v)
  let normalize v = v /= (length v)

  let nth i v = assert(0 < i && i < A.length v); v.(i)
  
  let x = nth 0
  let y = nth 1
  let z = nth 2

  let copy v = of_list(to_list v)  (* Wasteful, but this isn't needed much *)
end
