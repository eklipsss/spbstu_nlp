// 4.1) F#: Ввод вывод данных в файл или в консоль - программа, которая считывает текстовый файл 
// и подсчитывает количество слов + количество слов, в которых более 2-х гласных, и символов, записывая результат в новый файл.

open System
open System.IO

// Функция для подсчета количества гласных в слове
let countVowels (word: string) =
    let vowels = "aeiouAEIOUуеыаоэяиюУЕЫАОЭЯИЮ"
    word |> Seq.filter (fun c -> vowels.Contains(c)) |> Seq.length

// Функция для подсчета слов и слов с более 2-х гласных
let processFile (inputFile: string) (outputFile: string) =
    let text = File.ReadAllText(inputFile)
    let words = text.Split([| ' '; '\n'; '\r'; '\t' |], StringSplitOptions.RemoveEmptyEntries)
    let totalWords = words.Length
    let wordsWithMoreThanTwoVowels = words |> Array.filter (fun word -> countVowels(word) > 2) |> Array.length
    let totalChars = text.Length
    
    let result = sprintf "Total words: %d\nWords with more than 2 vowels: %d\nTotal characters: %d\n" totalWords wordsWithMoreThanTwoVowels totalChars
    File.WriteAllText(outputFile, result)
    printfn "\n" 
    printfn "Total words: %d\n" totalWords
    printfn "Words with more than 2 vowels: %d\n" wordsWithMoreThanTwoVowels
    printfn "Total characters: %d\n" totalChars
    
[<EntryPoint>]
let main argv =
    let inputFile = "/uploads/f_input.txt"
    let outputFile = "/uploads/f_output.txt"
    processFile inputFile outputFile
    0