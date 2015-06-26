(* !! Need vector/quat types *)
let valOf = function
    Some opt -> opt
  | None -> raise (Failure "No option")

let unitX = valOf V.unitX
let unitY = valOf V.unitY
let unitZ = valOf V.unitZ

type camera = { mutable position : vector3;
                mutable orientation : quat; 
                mutable fov : float; 
                mutable aspect : float; 
                mutable near_clip : float; 
                mutable far_clip : float }

let camera position orientation fov aspect near_clip far_clip =
    {position; orientation; fov; aspect; near_clip; far_clip}

(* Get properties *)
let get_position cam = cam.position
let get_direction cam = cam.orientation * V.(unixX ** -1)
let get_up = cam.orientation * unitY

let get_fov cam = cam.fov
let get_aspect_ratio = cam.aspect
let get_clips = (cam.near_clip, cam.far_clip)

(* Set render to use current state of camera *)
let update_view cam = ()             (* TODO *)
    (* Set the perspective matrix *)
    GlMat.mode `projection;
    GlMat.load_identity ();
    GluMat.perspective ...
    
    (* Set the modelview matrix *)
    GlMat.mode `modelview;
    GlMat.load_identity ();
    GlMat.translate ...
    GlMat.rotate ...
    GlMat.scale ...

(* Set properties *)
let translate cam vec = cam.position =
    V.(cam.position += Q.(cam.orientation ** vec))

let t_up cam n = () (* TODO *)
let t_down cam n = ()
let t_left cam n = ()
let t_right cam n = ()
let t_fward cam n = ()
let t_bward cam n = ()

let rotate cam vec rad = cam.orientation <-
    Q.normal Q.((Q.of_axis_angle vec rad) ** cam.orientation) (* TODO quat * quat mult *)

let pitch cam rad = rotate cam unitX rad
let roll cam rad = rotate cam unitZ rad
let yaw cam rad = rotate cam unitY rad

let set_fov cam fov = cam.fov <- fov
let set_aspect cam aspect = cam.aspect <- aspect
let set_clips cam (n, f) = cam.near_clip <- n; cam.far_clip <- f

(* Makes a fresh copy of a camera *)
let copy cam = { cam with position = V.copy cam.position }
