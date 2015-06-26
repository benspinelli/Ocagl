type button_t = Glut.button_t
type button_state_t = Glut.mouse_button_state_t

(* Keep bindings as hashtables *)
let keybinds = Hashtbl.create 32
let mousebinds = Hashtbl.create 8

(* Keep track of previous x/y for bindMotion *)
let px = ref 0
let py = ref 0

(* GLUT needs a single function for binding lookup *) 
let keylookup = fun ~key ~x ~y -> 
    try (Hashtbl.find keybinds key) x y with Not_found -> ()

let mouselookup = fun ~button ~state ~x ~y -> 
    px := x; py := y;
    try (Hashtbl.find mousebinds (button, state)) x y with Not_found -> ()
    
let motionlookup f = fun ~x ~y ->
    f x y (x - !px) (y - !py); px := x; py := y

(* Create and reset bindings *)
let bindKey c f =
    Hashtbl.replace keybinds (Char.code c) f;
    Glut.keyboardFunc ~cb: keylookup

let resetKeys () =
    Hashtbl.reset keybinds;
    Glut.keyboardFunc ~cb: keylookup

let bindMouse b s f =
    Hashtbl.replace mousebinds (b, s) f;
    Glut.mouseFunc ~cb: mouselookup

let resetMouse () =
    Hashtbl.reset mousebinds;
    Glut.mouseFunc ~cb: mouselookup

let bindMotion f =
    Glut.motionFunc ~cb: (motionlookup f)

let resetMotion () =
    Glut.motionFunc ~cb: (fun ~x ~y -> ())
