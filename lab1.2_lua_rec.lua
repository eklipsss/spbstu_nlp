-- 1.2) LUA: Рекурсия - треугольная последовательность
-- Дана монотонная последовательность, в которой каждое натуральное число k встречается ровно k раз.
-- По данному натуральному n необходимо вывести первые n членов этой последовательности.

-- Рекурсивная функция для вычисления треугольной последовательности
function triangular_sequence_helper(n, current, count, result)
    if #result >= n then
        return result
    end

    for i = 1, count do
        table.insert(result, current)
        if #result == n then
            return result
        end
    end

    return triangular_sequence_helper(n, current + 1, count + 1, result)
end

function triangular_sequence(n)
    return triangular_sequence_helper(n, 1, 1, {})
end

-- Пример использования
local n = 11 -- Задайте количество элементов
local sequence = triangular_sequence(n)

-- Вывод последовательности
for i, v in ipairs(sequence) do
    io.write(v, " ")
end
io.write("\n")
