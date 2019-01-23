(* ===== 1. NALOGA ====== *)

(* a *)
let intlist_to_string ys =
  let rec aux acc = function
  | [] -> acc
  | x :: xs -> aux (acc ^ (string_of_int x)) xs
  in
  aux "" ys

let izpisi_vsa_stevila ys =
  print_string (intlist_to_string ys)

(* b *)
let map2_opt f lst1 lst2 =
  let rec aux acc lst1 lst2 =
    match lst1, lst2 with
    | [], [] -> Some (List.rev acc)
    | [], _ | _, [] -> None
    | x :: xs, y :: ys -> aux ((f x y) :: acc) xs ys
  in
  aux [] lst1 lst2

(*====== 2. NALOGA ======*)

(* a *)

type filter_tree =
  | Node of filter_tree * int * filter_tree
  | Box of int list

let test_tree = Node(
    Node((Box [1]), 5, (Box [])), 
    10, 
    Node((Box []), 15, (Box [19; 20]))
    )

(* b *)
let rec vstavi k = function
  | Node(lt, n, rt) -> 
    if k <= n then
      Node (vstavi k lt, n, rt)
    else
      Node (lt, n, vstavi k rt)
  | Box(xs) -> Box (k :: xs)

(* c *)
let rec vstavi_seznam ys f_tree =  
  match ys with
  | [] -> f_tree
  | x :: xs -> vstavi_seznam xs (vstavi x f_tree)

(* d *)

(*====== 3. NALOGA ======*)

module type Linear = sig
  type t

  val id : t

  val uporabi : t -> int*int -> int*int

  val iz_matrike : int*int*int*int -> t

  val iz_funkcije : ((int*int) -> (int*int)) -> t

  val kompozitum : t -> t -> t
end

(* a *)
module Matrika : Linear = struct
  type t = int*int*int*int

  let id = (1, 0, 0, 1)
  let uporabi (a, b, c, d) (x, y) = (a*x + b*y, c*x + d*y)
  let iz_matrike matrika = matrika
  let iz_funkcije f = 
    let (a, c) = f (1, 0) in
    let (b, d) = f (0, 1) in
    (a, b, c, d)
  let kompozitum (a, b, c, d) (a', b', c', d') = 
    (a*a' + b*c', a*b' + b*d', c*a' + d*c', c*b + d*d')
end

module Function : Linear = struct
  type t = int*int -> int*int

  let id = (fun x -> x)
  let uporabi f x = f x
  let iz_matrike (a, b, c, d) = fun (x, y) -> (a*x + b*y, c*x + d*y)
  let iz_funkcije f = f
  let kompozitum f g = fun x -> f (g x)
end

