type color = float * float * float * float

let empty   = (0.0, 0.0, 0.0, 0.0)
let white   = (1.0, 1.0, 1.0, 1.0)
let black   = (0.0, 0.0, 0.0, 1.0)
let red     = (1.0, 0.0, 0.0, 1.0)
let green   = (0.0, 1.0, 0.0, 1.0)
let blue    = (0.0, 0.0, 1.0, 1.0)
let cyan    = (0.0, 1.0, 1.0, 1.0)
let magenta = (1.0, 0.0, 1.0, 1.0)
let yellow  = (1.0, 1.0, 0.0, 1.0)

let to_tuple c = c
let of_tuple c = c

let rgb (r, g, b, a) = (r, g, b)
let rgba c = c

let ( ++ ) (r1, g1, b1, a1) (r2, g2, b2, a2) =
    (r1 +. r2, g1 +. g2, b1 +. g2, a1 +. a2)

let ( -- ) (r1, g1, b1, a1) (r2, g2, b2, a2) =
    (r1 -. r2, g1 -. g2, b1 -. g2, a1 -. a2)

let ( ** ) (r1, g1, b1, a1) (r2, g2, b2, a2) =
    (r1 *. r2, g1 *. g2, b1 *. g2, a1 *. a2)

let mix colors = 
    let ilen = 1. /. (float List.length colors) in
    let sum = (List.fold_left (++) empty colors) in
    sum ** (of_tuple (ilen, ilen, ilen, ilen))

let ( +/ ) c1 c2 = mix [c1; c2]
