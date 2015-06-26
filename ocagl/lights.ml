(* !! Need vector type *)
module C = Color

(* Using this module automatically enables lighting *)
let _ = Gl.enable Gl.`lighting

type light = {ambient : C.color;
              specular : C.color;
              diffuse : C.color;
              position : vector3}

let light ambient specular diffuse position =
    {ambient; specular; diffuse; position}

let light_of_int = function
    0 -> Gl.`light0
  | 1 -> Gl.`light1
  | 2 -> Gl.`light2
  | 3 -> Gl.`light3
  | 4 -> Gl.`light4
  | 5 -> Gl.`light5
  | 6 -> Gl.`light6
  | 7 -> Gl.`light7
  | _ -> raise (Failure "Invalid light index")

let turnOnIdx i = Gl.enable (light_of_int i)
let turnOffIdx i = Gl.disable (light_of_int i)
let setIdx i light = raise (Failure "nyi") (* TODO *)
