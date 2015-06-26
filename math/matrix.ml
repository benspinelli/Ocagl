module type DIMS =
sig
  val rows : int
  val columns : int
end

module type MATRIX =
sig
  type matrix

  val rows : int
  val cols : int

  val zero : matrix
  val iden : matrix

  val of_lists = float list list -> matrix
  val to_lists = matrix -> float list list

  val ( ++ ) : matrix -> matrix -> matrix
  val ( += ) : matrix -> matrix -> unit
  val ( ** ) : matrix -> matrix -> matrix
  val ( *= ) : matrix -> matrix -> unit

  val row : int -> float list
  val col : int -> float list
  val entry : int -> int -> float

end

module Make(D : DIMS) : MATRIX =
struct
  type matrix = float array array

  let rows = D.rows
  let cols = D.columns

end
