// 6.2 SWIFT:  Конвертация данных из одного формата в другой - программа, которая преобразует данные из формата JSON в CSV и обратно.

import Foundation

// Преобразование JSON в CSV

/// Преобразует строку JSON в ассоциативный список (словарь).
/// - Parameter jsonStr: Строка в формате JSON.
/// - Returns: Словарь, полученный из JSON строки.
func parseJSON(jsonStr: String) -> [String: Any]? {
    let data = Data(jsonStr.utf8)
    do {
        // Преобразуем JSON строку в словарь
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        return jsonObject as? [String: Any]
    } catch {
        print("Ошибка при парсинге JSON: \(error)")
        return nil
    }
}

/// Преобразует словарь в строку CSV.
/// - Parameter jsonData: Словарь с данными для преобразования.
/// - Returns: Строка в формате CSV.
func jsonToCSV(jsonData: [String: Any]) -> String {
    let headers = jsonData.keys.joined(separator: ", ")
    let values = jsonData.values.map { "\($0)" }.joined(separator: ", ")
    return "\(headers)\n\(values)"
}

// Преобразование CSV в JSON

/// Преобразует строку CSV в словарь (JSON).
/// - Parameter csvStr: Строка в формате CSV.
/// - Returns: Словарь, полученный из CSV строки.
func csvToJSON(csvStr: String) -> [String: Any]? {
    let lines = csvStr.split(separator: "\n")
    guard lines.count == 2 else {
        print("Ошибка: неверный формат CSV.")
        return nil
    }
    
    let headers = lines[0].split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    let values = lines[1].split(separator: ",").map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
    
    var json: [String: Any] = [:]
    for (index, header) in headers.enumerated() {
        json[header] = values[safe: index]
    }
    
    return json
}

// Вспомогательные функции

/// Безопасное извлечение элемента по индексу в массиве.
extension Array {
    subscript(safe index: Int) -> Element? {
        return index >= 0 && index < count ? self[index] : nil
    }
}

/// Преобразует данные из JSON в CSV и записывает результат в файл.
func convertJSONToCSV(jsonFilePath: String, csvFilePath: String) {
    do {
        // Чтение JSON из файла
        let jsonStr = try String(contentsOfFile: jsonFilePath, encoding: .utf8)
        
        // Преобразование JSON в словарь
        if let jsonData = parseJSON(jsonStr: jsonStr) {
            // Преобразование в CSV
            let csvStr = jsonToCSV(jsonData: jsonData)
            
            // Запись в файл CSV
            try csvStr.write(toFile: csvFilePath, atomically: true, encoding: .utf8)
            
            print("JSON успешно преобразован в CSV!")
            print(csvStr)  // Вывод результата в консоль
        }
    } catch {
        print("Ошибка при работе с файлом: \(error)")
    }
}

/// Преобразует данные из CSV в JSON и записывает результат в файл.
func convertCSVToJSON(csvFilePath: String, jsonFilePath: String) {
    do {
        // Чтение CSV из файла
        let csvStr = try String(contentsOfFile: csvFilePath, encoding: .utf8)
        
        // Преобразование CSV в JSON
        if let jsonData = csvToJSON(csvStr: csvStr) {
            // Преобразование в JSON строку
            let jsonData = try JSONSerialization.data(withJSONObject: jsonData, options: .prettyPrinted)
            let jsonStr = String(data: jsonData, encoding: .utf8)!
            
            // Запись в файл JSON
            try jsonStr.write(toFile: jsonFilePath, atomically: true, encoding: .utf8)
            
            print("CSV успешно преобразован в JSON!")
            print(jsonStr)  // Вывод результата в консоль
        }
    } catch {
        print("Ошибка при работе с файлом: \(error)")
    }
}

// Пример использования

// Преобразование JSON в CSV
let jsonFilePath = "/uploads/input.json"
let csvFilePath = "/myfiles/output.csv"
convertJSONToCSV(jsonFilePath: jsonFilePath, csvFilePath: csvFilePath)

// Преобразование CSV обратно в JSON
let newJsonFilePath = "/myfiles/output_from_csv.json"
convertCSVToJSON(csvFilePath: csvFilePath, jsonFilePath: newJsonFilePath)
