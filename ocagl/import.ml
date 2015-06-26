module G = Geometry
module M = Material

exception ImportError of string

(* parsePly : in_channel -> mesh *)
let parsePly ch = ()

(* parseObj : in_channel -> mesh *)
let parseObj ch = ()

(* parseBmp : in_channel -> texture *)
let parseBmp ch = ()

let readFile file parse_fun =
    let ch = (try open_in file with Sys_error s -> raise ImportError s) in
    let obj = (try parse_fun ch with excp -> close_in ch; raise excp) in obj

let importPly file = readFile file parsePly
let importObj file = readFile file parseObj
let importBmp file = readFile file parseBmp
