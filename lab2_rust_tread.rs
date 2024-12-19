// 2) Rust: Работа с многопоточностью - функция для сортировки массива


use std::fs;
use std::thread;
use std::io::{self, BufRead};

// Функция для сортировки массива
fn sort_array(mut arr: Vec<i32>) -> Vec<i32> {
    arr.sort();
    arr
}

// Функция для чтения массива из файла
fn read_array_from_file(filename: &str) -> io::Result<Vec<i32>> {
    let file = fs::File::open(filename)?;
    let reader = io::BufReader::new(file);
    let mut array = Vec::new();

    for line in reader.lines() {
        let line = line?;
        if let Ok(num) = line.trim().parse::<i32>() {
            array.push(num);
        }
    }

    Ok(array)
}

fn main() {
    // Список файлов с массивами
    let filenames = vec!["/uploads/array1.txt", "/uploads/array2.txt", "/uploads/array3.txt"];

    // Чтение массивов из файлов
    let mut arrays = Vec::new();
    for filename in &filenames {
        match read_array_from_file(filename) {
            Ok(array) => arrays.push(array),
            Err(e) => {
                eprintln!("Failed to read {}: {}", filename, e);
                return;
            }
        }
    }

    // Создание вектора для хранения потоков
    let mut handles = vec![];

    // Создание и запуск потоков для сортировки массивов
    for arr in arrays {
        let handle = thread::spawn(move || {
            sort_array(arr)
        });
        handles.push(handle);
    }

    // Ожидание завершения всех потоков и сбор результатов
    for handle in handles {
        match handle.join() {
            Ok(sorted_array) => println!("{:?}", sorted_array),
            Err(_) => eprintln!("Thread panicked!"),
        }
    }
}
