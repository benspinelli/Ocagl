(* !! Need vector type *)
module C = Color

type light = {ambient : C.color;
              specular : C.color;
              diffuse : C.color;
              position : vector3}


val light : C.color -> C.color -> C.color -> vector3 -> light
val turnOnIdx : int -> unit
val turnOffIdx : int -> unit
val setIdx : light -> int -> unit
