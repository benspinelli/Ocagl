(* The Magic structure is a collection of all "magic numbers" and constants
 * pertaining to performance related tweaks throughout the framework. The value
 * of these constants has been determined partially through reasoning and
 * partially through brute-force comparison of different combinations.
 *)

val numcores : int          (* Cores to be used in parallel operations *)
val setGC : unit -> unit    (* Tweak garbage collection settings *)

external fastNormalize : float array -> unit = "fastInvSqrtArr"
