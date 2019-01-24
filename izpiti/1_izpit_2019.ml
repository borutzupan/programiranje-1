(*====== 1. NALOGA ======*)

(* a *)

let podvoji_vsoto x y = 2 * (x + y)

(* b *)

let povsod_vecji (a, b, c) (a', b', c') =
  if ((a > a') && (b > b') && (c > c')) then true else false

(* c *)

let uporabi_ce_lahko f x =
  match x with
  | None -> None
  | Some(x) -> f x

(* d *)

let  pojavi_dvakrat i lst =
  let rec aux acc = function
  | [] -> acc
  | x :: xs ->
    if i = x then 
      aux (x :: acc) xs 
    else 
      aux acc xs
  in
  if List.length (aux [] lst) = 2 then true else false

(* e *)

let izracunaj_v_tocki i lst =
  let rec aux acc = function
  | [] -> List.rev acc
  | f :: fs -> aux ((f i) :: acc) fs
  in
  aux [] lst

(* f *)

let eksponent x p =
  let rec aux acc x p =
    match p with
    | 0 -> acc
    | p -> aux (x * acc) x (p - 1)
    in
    aux 1 x p

(*====== 2. NALOGA ======*)

(* a *)

type 'a mm_drevo =
  | Empty
  | Node of 'a mm_drevo * 'a * 'a * 'a mm_drevo

let leaf x s = Node (Empty, x, s , Empty)

let test_drevo = Node(leaf 1 3, 2, 2, Node(leaf 4 1, 5, 1, leaf 8 2))

(* b *)

let rec vstavi i = function
  | Empty -> leaf i 1
  | Node (lt, x, y, rt) when i = x -> Node (lt, x, (y + 1), rt)
  | Node (lt, x, y, rt) when i < x -> Node (vstavi i lt, x, y, rt)
  | Node (lt, x, y, rt) -> Node (lt, x, y, vstavi i rt)

(* c *)

let multimnozica_iz_seznama lst =
  let rec aux acc = function
  | [] -> acc
  | x :: xs -> aux (vstavi x acc) xs
  in
  aux Empty lst

(* d *)

let sestej_sez sez = 
  let rec aux acc = function
  | [] -> acc
  | x :: xs -> aux (x + acc) xs
  in
  aux 0 sez
  
let rec velikost_mnozice drevo =
  match drevo with
  | Empty -> 0
  | Node (lt, x, y, rt) ->
    let left = velikost_mnozice lt in
    let right = velikost_mnozice rt in
    let vse_moznosti = [left; right; y] in
    sestej_sez vse_moznosti

(* e *)

let rec dodaj x y sez =
  match y with
  | 0 -> sez
  | y -> dodaj x (y - 1) (x :: sez)

let rec seznam_iz_multimnozice drevo =
  match drevo with
  | Empty -> []
  | Node (lt, x, y, rt) -> 
    let left = seznam_iz_multimnozice lt in
    let right = seznam_iz_multimnozice rt in
    let vsi_sez = [left; dodaj x y []; right] in
    List.concat vsi_sez
