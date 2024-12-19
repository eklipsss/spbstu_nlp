(* 1.3) OCAML: Рекурсия - без двух нулей *)
(* Необходимо определить, сколько существует последовательностей из a нулей и b единиц, *)
(* в которых никакие два нуля не стоят рядом и вывести эти последовательности. *)

(* Функция для подсчета заданных последовательностей *)
let rec recursion a b =
  (* Базовый случай *)
  if a > b + 1 then 0
  (* Базовый случай *)
  else if a = 0 || b = 0 then 1
  (* Шаг рекурсии / рекурсивное условие *)
  else recursion a (b - 1) + recursion (a - 1) (b - 1)

(* Функция для генерации заданных последовательностей *)
let rec generate_sequences a b prefix =
  if a > b + 1 then []
  else if a = 0 then [prefix ^ (String.make b '1')]
  else if b = 0 then [prefix ^ (String.make a '0')]
  else
    let seq1 = generate_sequences a (b - 1) (prefix ^ "1") in
    let seq2 = generate_sequences (a - 1) (b - 1) (prefix ^ "01") in
    seq1 @ seq2


(* Пример использования *)

let () =
  let result = recursion 3 4 in
  Printf.printf "a = 3, b = 4: number of sequences = %d\n" result;
  let sequences = generate_sequences 3 4 "" in
  List.iter (Printf.printf "  %s\n") sequences

let () =
  let result = recursion 5 4 in
  Printf.printf "a = 5, b = 4: number of sequences = %d\n" result;
  let sequences = generate_sequences 5 4 "" in
  List.iter (Printf.printf "  %s\n") sequences
  
let () =
  let result = recursion 6 4 in
  Printf.printf "a = 6, b = 4: number of sequences = %d\n" result;
  let sequences = generate_sequences 6 4 "" in
  List.iter (Printf.printf "  %s\n") sequences