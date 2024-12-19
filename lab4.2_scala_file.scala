// 4.2) Scala: Ввод вывод данных в файл или в консоль - программа, которая считывает текстовый файл 
// и подсчитывает количество уникальных слов, записывая результат в новый файл.

import scala.io.Source
import java.io.PrintWriter
import java.io.FileNotFoundException
import java.io.IOException

object JDoodle {
  // Функция для подсчета уникальных слов
  def countUniqueWords(text: String): Int = {
    val words = text.split("\\W+").filter(_.nonEmpty) // Убираем пустые строки
    val uniqueWords = words.map(_.toLowerCase).toSet // Приводим к одному регистру
    uniqueWords.size
  }

  def main(args: Array[String]): Unit = {
    val inputFile = "/uploads/scala_input.txt"
    val outputFile = "/uploads/scala_output.txt"

    try {
      // Чтение содержимого файла
      val text = Source.fromFile(inputFile).getLines.mkString(" ")

      // Проверка, содержит ли файл текст
      if (text.trim.isEmpty) {
        println(s"Input file '$inputFile' is empty or contains no valid words.")
        return
      }

      // Подсчет уникальных слов
      val uniqueWordsCount = countUniqueWords(text)

      // Запись результата в файл
      val writer = new PrintWriter(outputFile)
      writer.write(s"Unique words count: $uniqueWordsCount\n")
      writer.close()

      // Вывод результата в консоль
      println(s"Unique words count: $uniqueWordsCount")
      println(s"Result written to file '$outputFile'")
    } catch {
      case e: FileNotFoundException =>
        println(s"Error: File '$inputFile' not found.")
      case e: IOException =>
        println(s"Error reading file '$inputFile': ${e.getMessage}")
    }
  }
}
