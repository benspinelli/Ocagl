(* A simple quaternion library. It takes a vector implementation and *
 * implements quaternions and conversions to/from axis-angle format  *
 * from it. If the vector implemention is not an implementation of   *
 * 3-dimensional, float vectors, it will not compile.                *)

module type QUATERNION =
sig
  type quat
  type vector3

  val zero : quat  (* Quaternion of zeros *)
  val id : quat    (* Identity rotation   *)
  
  val of_tuple : float * float * float * float -> quat
  val to_tuple : quat -> float * float * float * float
  
  val of_axis_angle : vector3 * float -> quat
  val to_axis_angle : quat -> vector3 * float

  (* Rotate a vector by a quaternion *)
  val ( ** ) : quat -> vector3 -> vector3
  val ( *= ) : quat -> vector3 -> unit

  val normal : quat -> quat
  val conj : quat -> quat
end

(* V must have type elem as float *)
module Make(V : Vector.VECTOR with type elem = float) : QUATERNION =
struct
  type quat = {w:float; x:float; y:float; z:float}
  type vector3 = V.vector
  
  (* V must have dimension 3 *)
  let _ = if V.dim <> 3 then assert(false)
      
  let zero = {w=0.; x=0.; y=0.; z=0.}
  let id = {w=1.; x=0.; y=0.; z=0.}

  let of_tuple (w, x, y, z) = {w=w; x=x; y=y; z=z}
  let to_tuple q = (q.w, q.x, q.y, q.z)
  
  let normal q =
      let n = 1. /. sqrt(q.w*.q.w +. q.x*.q.x +. q.y*.q.y +. q.z*.q.z) in
      of_tuple (n *. q.w, n *. q.x, n *. q.y, n *. q.z)
 
  let conj q = of_tuple (q.w, -.q.x, -.q.y, -.q.z)
  
  let of_axis_angle (v, rad) =
      let rad = 0.5 *. rad in
      let nv = V.normal v in
      let s = sin rad in
      let q = of_tuple (cos rad, s *. (V.x nv), s *. (V.y nv), s *. (V.z nv)) in
      normal q
  
  let to_axis_angle q =
    let n = (q.x*.q.x +. q.y*.q.y +. q.z*.q.z) in
    if n > 0. then
        let ilen = 1. /. (sqrt n) in
        (V.of_list [q.x *. ilen; q.y *. ilen; q.z *. ilen], 2. *. (acos q.w))
    else
        ((match V.unitX with Some x -> x | _ -> raise (Failure "no axis")), 0.)

  let ( ** ) = raise (Failure "unimplemented")
  let ( *= ) = raise (Failure "unimplemented")

end
