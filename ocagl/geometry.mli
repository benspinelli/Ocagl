type triangle
type plane
type sphere
type mesh

(* Translation, Rotation, and Scaling data for transformation *)
type world_info = vector3 * quat * vector3

type geom = T of triangle * world_info
          | P of plane * world_info
          | S of sphere * world_info
          | M of mesh * world_info

(* Triangles are determined by their vertices,
 * Planes by any three points on them,
 * Spheres by center and radius,
 * Meshes by an array of points and a list of index triplets (triangles) *)
val triangle : vector3 -> vector3 -> vector3 -> material -> triangle
val plane : vector3 -> vector3 -> vector3 -> material -> plane
val sphere : vector3 -> float -> material -> sphere
val mesh : v3a -> v3a -> (int * int * int) list -> material -> mesh

val render_geom : geom -> unit
val normal : triangle -> vector3
