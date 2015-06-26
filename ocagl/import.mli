(* Functions to import the contents of .ply and .obj files as mesh objects.
 * On failure, the functions raise ImportError with an appropriate error
 * message.                                                                *)

exception ImportError of string

val importPly : string -> Geometry.mesh
val importObj : string -> Geometry.mesh
val importBmp : string -> Material.texture
