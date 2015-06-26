(* See magic.mli for description of each constant *)

let numcores = 4
let setGC () = ()

external fastNormalize : float array -> unit = "fastInvSqrtArr"
