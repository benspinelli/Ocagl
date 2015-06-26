type color

(* Color constants *)
val white : color
val black : color
val red : color
val green : color
val blue : color
val cyan : color
val magenta : color
val yellow : color

(* Type conversions *)
val to_tuple : color -> float * float * float * float
val of_tuple : float * float * float * float -> color

val rgb : color -> Gl.rgb
val rgba : color -> Gl.rgba

(* Color arithmetic *)
val ( ++ ) : color -> color -> color
val ( -- ) : color -> color -> color
val ( ** ) : color -> color -> color

(* Average two or more colors *)
val ( +/ ) : color -> color -> color
val mix : color list -> color

(* Equality *)
val ( == ) : color -> color -> bool

(* clamp c min max compenentwise clamps the color *)
val clamp : color -> float -> float -> color
