(*======== 1. NALOGA ========*)

(* a *)
let uporabi f x = f x

(* b *)
let ibaropu x f = f x

(* c *)
let zacetnih n lst =
  let rec zacetnih' acc n xs =
    match xs with
    | [] -> None
    | y :: ys -> 
      if n > List.length xs then
        None
      else
        if n > 0 then
          zacetnih' (y :: acc) (n - 1) ys
        else
          Some (List.rev(acc))
  in
  zacetnih' [] n lst

let test_zac = zacetnih 3 [1; 3; 2; 5; 4; 3; 1]

(*======== 2. NALOGA ========*)

type 'a neprazen_sez = 
    | Konec of 'a 
    | Sestavljen of 'a * 'a neprazen_sez

let y = Sestavljen (3, Sestavljen (1, Sestavljen(2, Konec (4))))
let z = Konec(2)

(* a *)
let prvi = function
  | Konec(x) -> x
  | Sestavljen(x, xs) -> x

let rec zadnji = function
  | Konec(x) -> x
  | Sestavljen(x, xs) -> zadnji xs

(* b *)
let dolzina nep_sez =
  let rec dolzina' acc = function
  | Konec(x) -> acc + 1
  | Sestavljen(x, xs) -> dolzina' (acc + 1) xs
  in
  dolzina' 0 nep_sez

(* c *)
let pretvori nep_sez =
  let rec pretvori' acc = function
  | Konec(x) -> List.rev (x :: acc)
  | Sestavljen(x, xs) -> pretvori' (x :: acc) xs
  in
  pretvori' [] nep_sez

(* d *)
let rec zlozi f a nep_sez =
  match nep_sez with
  | Konec(x) -> f a x
  | Sestavljen(x, xs) -> zlozi f (f a x) xs

(*======== 3. NALOGA ========*)

(* a *)
let test_string = "01010"

(* Za rešitev te naloge bom potreboval nekaj pomožnih funkcij. *)
let reverse_string s =
  let rec aux idx =
    if idx >= String.length s then 
      "" 
    else 
      (aux (idx + 1))^(String.make 1 s.[idx])
  in
  aux 0


let rec even n =
  match n with
  | 0 -> true
  | x -> odd (x - 1)
and odd n =
  match n with
  | 0 -> false
  | x -> even (x - 1)


let simetricen s =
  match s with
  | "" | "x" -> true
  | xs ->
    if odd (String.length xs) = true then
      let sredina_odd = ((String.length xs) - 1) / 2 in
      if String.sub xs 0 sredina_odd = reverse_string(String.sub xs (sredina_odd + 1) sredina_odd) then
        true
      else
        false
    else
      let sredina_even = (String.length xs) / 2 in
      if String.sub xs 0 sredina_even = reverse_string(String.sub xs sredina_even sredina_even) then
        true
      else false

let simetricen_bolje s =
  match s with
  | "" | "x" -> true
  | xs -> 
    if xs = reverse_string xs then true else false
