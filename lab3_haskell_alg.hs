-- 3) Haskell: Решение алгебраической задачи (алгоритмическая) - нахождение производной функции в заданной точке.

-- Функция для вычисления производной в точке
derivative :: (Double -> Double) -> Double -> Double -> Double
derivative f x h = (f (x + h) - f x) / h

-- Пример функции
exampleFunction :: Double -> Double
exampleFunction x = x^2 + 3*x + 2

main :: IO ()
main = do
    let x = 2.0
    let h = 0.00001
    let deriv = derivative exampleFunction x h
    putStrLn ("Производная от функции в точке x = " ++ show x ++ " is " ++ show deriv)