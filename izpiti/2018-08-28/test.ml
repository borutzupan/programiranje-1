(* ==== 1. naloga ===== *)

let razlika_kvadratov x y = ((x + y) * (x + y)) - ((x * x) + (y * y))

let uporabi_na_paru f (a, b) = (f a, f b)

let rec ponovi_seznam n sez =
  match n with
  | n when n <= 0 -> []
  | n -> sez @ (ponovi_seznam (n - 1) sez)

let razdeli sez =
  let rec razdeli' n_acc p_acc = function
  | [] -> (List.rev n_acc, List.rev p_acc)
  | x :: xs when x < 0 -> razdeli' (x :: n_acc) p_acc xs
  | x :: xs -> razdeli' n_acc (x :: p_acc) xs
  in
  razdeli' [] [] sez

(* ==== 2. naloga ===== *)

type 'a drevo =
  | Empty
  | Node of 'a drevo * 'a * 'a drevo

let leaf x = Node (Empty, x , Empty)

let test_drevo1 =
  let l_drevo = Node(leaf 3, 10, Node(leaf 14, 13, leaf 6)) in
  let r_drevo = Node(leaf 2, 8, leaf 10) in
  Node(l_drevo, 11, r_drevo)

let test_drevo2 = 
  let l_drevo = Node(leaf 20, 10, Node(leaf 15, 6, leaf 9)) in
  let r_drevo = Node(leaf 1, 4, leaf 10) in
  Node(l_drevo, 7, r_drevo)
  
let rec padajoca v = function
  | Empty -> []
  | Node (lt, x, rt) when x > v -> []
  | Node (lt, x, rt) -> 
    let left = padajoca x lt in
    let right = padajoca x rt in
    if List.length left > List.length right then
      left @ [x]
    else
      right @ [x]

let rec narascajoca v = function
  | Empty -> []
  | Node (lt, x, rt) when x < v -> []
  | Node (lt, x, rt) -> 
    let left = narascajoca x lt in
    let right = narascajoca x rt in
    if List.length left > List.length right then
      x :: left
    else
      x :: right

let rec monotona_pot = function
  | Empty -> []
  | Node(lt, x, rt) ->
    (* Recursive search for paths. *)
    let pure_left = monotona_pot lt in
    let pure_right = monotona_pot rt in
    let left_to_right = (padajoca x lt) @ [x] @ (narascajoca x rt) in
    let right_to_left = (padajoca x rt) @ [x] @ (narascajoca x lt) in
    (* Choose the longest one. *)
    let options = [pure_left; pure_right; left_to_right; right_to_left] in
    let pick_bigger x y = if List.length x > List.length y then x else y in
    List.fold_left pick_bigger pure_left options

(* ==== 3. naloga ===== *)

type 'a veriga = 
  | Filter of ('a -> bool) * 'a list * 'a veriga
  | Ostalo of 'a list

let test =
  Filter ((fun x -> x < 0), [],
  Filter ((fun x -> x < 10), [],
  Ostalo []))

let rec vstavi x veriga =
  match veriga with
  | Ostalo (elementi) -> Ostalo (x :: elementi)
  | Filter (f, elementi, filtri) ->
    if f x then
      Filter(f, x :: elementi, filtri)
    else
      Filter(f, elementi, vstavi x filtri)

let rec poisci x = function
  | Ostalo elementi -> List.mem x elementi
  | Filter(f, elementi, filtri) ->
    if f x then List.mem x elementi else poisci x filtri

let rec izprazni = function
  | Ostalo elementi -> (Ostalo [], elementi)
  | Filter (f, elementi, filtri) ->
    let prazni_filtri, pobrani_elementi = izprazni filtri in
    let vsi_elementi = elementi @ pobrani_elementi in
    (Filter (f, [], prazni_filtri), vsi_elementi)

let dodaj f veriga =
  let veriga' = Filter(f, [], veriga) in
  let prazna_veriga, elementi = izprazni veriga' in
  List.fold_left (fun v x -> vstavi x v) prazna_veriga elementi

let test3 = List.fold_left (fun v x -> vstavi x v) test [(-3); 2; 3; 4; 100; 20]
