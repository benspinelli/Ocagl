module A = Array

(* float arrays are unboxed in Ocaml, this provides a speed advantage
 * over float array arrays by increasing locality and reducing the work
 * done by the garbage collector                                        *)
type v3a = float array

let tabulate i f =
    let arr = A.make (3*i) 0. in
    for n = 0 to (i-1) do
        let (x, y, z) = f i in
        arr.(n * 3 + 0) <- x;
        arr.(n * 3 + 1) <- y;
        arr.(n * 3 + 2) <- z
    done; arr

let set f arr =
    let i = (A.length arr) / 3 in
    for n = 0 to (i-1) do
        let (x, y, z) = f i in
        arr.(n * 3 + 0) <- x;
        arr.(n * 3 + 1) <- y;
        arr.(n * 3 + 2) <- z
    done

let map f arr =
    let i = (A.length arr) / 3 in
    for n = 0 to (i-1) do
        let (x, y, z) = f (arr.(n*3), arr.(n*3+1), arr.(n*3+2)) in
        arr.(n * 3 + 0) <- x;
        arr.(n * 3 + 1) <- y;
        arr.(n * 3 + 2) <- z
    done

(* Keep a length parameter *)
let rec reduce' i b f arr = match i with
      0 -> b
    | n -> let s = f b (arr.(i-1), arr.(i-2), arr.(i-3)) in
           reduce' (i-3) s f arr

let reduce b f arr = reduce' (A.length arr) b f arr
        
let normalize = Magic.fastNormalize

let copy = A.copy

let copy_map f arr = let c = copy arr in map f c; c
