// 6.1) Scala: Конвертация данных из одного формата в другой - программа, 
// которая преобразует данные из формата XML в JSON и обратно.

// 
import scala.io.Source
import java.io.PrintWriter

object JDoodle {

  // Преобразование XML в JSON
  def xmlToJson(xmlString: String): String = {
    // Удаляем пробелы и символы новой строки, чтобы обработать строку
    val trimmedXml = xmlString.replaceAll("\\s+", " ").trim
    
    // Регулярное выражение для извлечения тегов и значений
    val tagRegex = "<(\\w+)>(.*?)</\\1>".r

    // Извлекаем все теги и значения из XML
    val jsonFields = tagRegex.findAllIn(trimmedXml).matchData.map { m =>
      val key = m.group(1)   // имя тега
      val value = m.group(2) // значение тега
      s""""$key": "$value""""
    }.mkString(", ")

    // Формируем строку JSON
    s"{ $jsonFields }"
  }

  // Преобразование JSON в XML
  def jsonToXml(jsonString: String): String = {
    // Убираем фигурные скобки и лишние пробелы
    val trimmedJson = jsonString.stripPrefix("{").stripSuffix("}").trim

    // Разделяем на ключ-значение
    val fields = trimmedJson.split(",").map(_.trim)

    // Преобразуем каждое ключ-значение в XML
    val xmlFields = fields.map { field =>
      val Array(key, value) = field.split(":").map(_.trim.stripPrefix("\"").stripSuffix("\""))
      s"<$key>$value</$key>"
    }.mkString("\n")

    // Формируем итоговый XML
    s"<root>\n$xmlFields\n</root>"
  }

  // Чтение файла с помощью Source
  def readFile(filePath: String): String = {
    // Используем Source для чтения файла
    val source = Source.fromFile(filePath)
    try {
      source.getLines().mkString("\n") // Собираем все строки в одну
    } finally {
      source.close() // Закрываем источник
    }
  }

  // Запись в файл с помощью PrintWriter
  def writeFile(filePath: String, content: String): Unit = {
    // Используем PrintWriter для записи в файл
    val writer = new PrintWriter(filePath)
    try {
      writer.write(content) // Пишем содержимое в файл
    } finally {
      writer.close() // Закрываем writer
    }
  }

  // Пример использования
  def main(args: Array[String]): Unit = {
    // Чтение XML из файла
    val xmlInput = readFile("/uploads/input.xml")
    println("XML Input:")
    println(xmlInput)

    // Преобразуем XML в JSON
    val jsonOutput = xmlToJson(xmlInput)
    println("\nConverted JSON:")
    println(jsonOutput)

    // Записываем JSON в файл
    writeFile("/myfiles/output.json", jsonOutput)

    // Чтение JSON из файла
    val jsonInput = readFile("/myfiles/output.json")
    println("\nJSON Input from file:")
    println(jsonInput)

    // Преобразуем JSON обратно в XML
    val xmlBack = jsonToXml(jsonInput)
    println("\nConverted back to XML:")
    println(xmlBack)

    // Записываем XML в файл
    writeFile("/myfiles/output.xml", xmlBack)
  }
}
