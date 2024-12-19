# 4.2) Elixir: Ввод вывод данных в файл или в консоль - программа, 
# которая считывает текстовый файл и подсчитывает количество уникальных слов, записывая результат в новый файл.


defmodule WordCounter do
  # Функция для подсчета уникальных слов
  def count_unique_words(text) do
    text
    |> String.split(~r/\W+/)  # Разделяем текст по любым неалфавитным символам
    |> Enum.filter(&(&1 != ""))  # Убираем пустые строки
    |> Enum.map(&String.downcase/1)  # Приводим все слова к нижнему регистру
    |> Enum.uniq()  # Находим уникальные слова
    |> length()  # Возвращаем количество уникальных слов
  end

  # Основная функция, которая считывает файл и записывает результат в другой файл
  def process_files(input_file, output_file) do
    case File.read(input_file) do
      {:ok, content} ->
        # Подсчитываем количество уникальных слов
        unique_words_count = count_unique_words(content)

        # Записываем результат в новый файл
        File.write(output_file, "Unique words count: #{unique_words_count}\n")
        IO.puts("Unique words count: #{unique_words_count}")
        IO.puts("Result written to file '#{output_file}'")

      {:error, :enoent} ->
        IO.puts("Error: File '#{input_file}' not found.")

      {:error, reason} ->
        IO.puts("Error reading file '#{input_file}': #{reason}")
    end
  end
end

# Пример использования
input_file = "/uploads/scala_input.txt"
output_file = "/uploads/scala_output.txt"
WordCounter.process_files(input_file, output_file)
