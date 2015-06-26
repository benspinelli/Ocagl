type triangle = float * float * float
type plane = unit
type sphere = unit
type mesh = triangle list

type world_info = vector3 * quat * vector3

type geom = T of triangle * world_info
          | P of plane * world_info
          | S of sphere * world_info
          | M of mesh * world_info

val triangle a b c mat = raise (Failure "nyi")
val plane a b c mat = raise (Failure "nyi")
val sphere c r mat = raise (Failure "nyi")
val mesh : v3a -> v3a -> (int * int * int) list -> material -> mesh

val render_geom geom =
    (* Push modelview matrix *)
    GlMat.mode `modelview;
    GlMat.push ();

    (* Make transformations *)
    GlMat.translate ...
    GlMat.rotate ...
    GlMat.scale ...

    (* Set material information *)

    (* Draw the geometry *)
    match geom with
        T(t, info) -> raise (Failure "Triangle geom nyi.")
      | P(p, info) -> raise (Failure "Plane geom nyi.")
      | S(s, info) -> raise (Failure "Sphere geom nyi.")
      | M(m, info) -> raise (Failure "Mesh geom nyi.")

    (* Pop the modelview matrix *)
    GlMat.pop ();

val normal tri = raise (Failure "nyi")
