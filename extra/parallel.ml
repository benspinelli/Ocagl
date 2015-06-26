open Parmap

(* Number of cores to use *)
let cores = ref Magic.numcores

(* Default debugging functions *)
let dbg_print_init n = ()   (* TODO *)
let dbg_print_final () = () (* TODO *)

let par2 f a b =
    let [fa; fb] = if !cores > 1
      then parmap ~ncores: 2 f (L [a; b])
      else List.map f [a; b]
    in (fa, fb)

let par3 f a b c =
    let [fa; fb; fc] = if !cores > 1
      then parmap ~ncores: (max 3 !cores) f (L [a; b; c])
      else List.map f [a; b; c]
    in (fa, fb, fc)

let fnpar2 f g =
    let [fv; gv] = if !cores > 1
      then parmap ~ncores: 2 (fun f -> f ()) (L [f; g])
      else [f (); g ()]
    in (fv, gv)

let fnpar3 f g h =
    let [fv; gv; gh] = if !cores > 1
      then parmap ~ncores: (max 3 !cores) (fun f -> f ()) (L [f; g; h])
      else [f (); g (); h()]
    in (fv, gv, gh)
