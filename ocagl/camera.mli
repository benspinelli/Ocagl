(* An implementation of camera-related functions. Cameras are implemented as
 * an ADT, so values of type camera can be stored or passed around. Each
 * camera contains the necessary information for the other compents of Ocagl
 * to render a scene from its perspective                                    *)

type camera

(* Camera constructor *)
val camera : vector3 -> quat -> float -> float -> float -> float -> camera

(* Get camera properties *)
val get_position : camera -> vector3
val get_direction : camera -> vector3
val get_up : camera -> vector3

val get_fov : camera -> float
val get_aspect_ratio : camera -> float
val get_clips : camera -> float * float

(* Set render view to use current state of camera *)
val update_view : camera -> unit

(* Translate camera in some direction *)
val translate : camera -> vector3 -> unit
val t_up : camera -> float -> unit
val t_down : camera -> float -> unit
val t_left : camera -> float -> unit
val t_right : camera -> float -> unit
val t_fward : camera -> float -> unit
val t_bward : camera -> float -> unit

(* Rotate around X, Z, and Y axes (radians) *)
val pitch : camera -> float -> unit
val roll : camera -> float -> unit
val yaw : camera -> float -> unit

(* Rotate around arbitrary axis (radians) *)
val rotate : camera -> vector3 -> float -> unit

(* Set other properties *)
val set_fov : camera -> float -> unit
val set_aspect : camera -> float -> unit
val set_clips : camera -> (float * float) -> unit

(* Make a fresh copy of a camera *)
val copy : camera -> camera
