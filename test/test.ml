module C = Color
module D = Devices
module G = Geometry
module I = Import
module L = Lights

let width = ref 1
let height = ref 1

let reshape ~w ~h = 
    width := max 1 w;
    height := max 1 h;
    GlDraw.viewport 0 0 w h

(* Create a camera *)
let cam = () (* TODO *)

(* Geometry & Functions *)
let pool_info = () (* TODO *)
let pool = G.M (I.importObj "pool.obj", pool_info)
let water_info = ()
let water = ()
let update_water () = () 

let initWindow () =
    let _ = Glut.init Sys.argv in
    let _ = Glut.initDisplayMode ~depth:true ~double_buffer:true () in
    let _ = Glut.createWindow ~title:"Test GL Project" in
            Glut.reshapeFunc ~cb:reshape

(* Register keypresses for camera movement *)
let registerKeypresses () =
    D.bindKey '\027' (fun x y -> exit 0);
    D.bindKey 'l' (fun x y -> Printf.printf "x is %d. y is %d.\n%!" x y);

    (*
    D.bindKey 'w' (fun x y -> C.t_fward 1.0);
    D.bindKey 'a' (fun x y -> C.t_left 1.0);
    D.bindKey 's' (fun x y -> C.t_right 1.0);
    D.bindKey 'd' (fun x y -> C.t_bward 1.0)
    *)

(* Register mouse movements for camera movement *)
let registerMouseEvents () =
    D.bindMouse Glut.LEFT_BUTTON Glut.DOWN 
        (fun x y -> Printf.printf "x is %d. y is %d.\n%!" x y);
    D.bindMotion
        (fun x y dx dy -> Printf.printf "x is %d. y is %d. dx is %d dy is %d\n%!" x y dx dy)

(* Set the camera to be used by the render function *)
let initCamera () =
    C.update_view cam; 

(* Set the lights *)
let initLighting () =
    let light0 = L.light C.black C.white C.white V.zero in
    L.setIdx 0 light0; 
    L.turnOnIdx 0

(* Main render loop *)
let render () =
    (* Set camera, real work done in Camera module *)
    C.update_view cam;

    (*
    (* Draw objects, real work done in Geometry module *)
    update_water ();
    G.render_geom pool;
    G.render_geom water; 
    *)

    (* Clean up *)
    Gl.flush ();
    Glut.swapBuffers ()

let registerRenderFunc () =
    Glut.displayFunc ~cb:render;
    Glut.idleFunc ~cb:(Some Glut.postRedisplay)

let go () =
    Glut.mainLoop ()
