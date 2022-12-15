-- функция, която намира n!
fact 0 = 1
fact n = n * fact (n - 1)

-- алтернативно решение за
-- функция, която намира n!
-- fact n = product [1..n]

facts = [ fact i | i <- [0..]] 

-- алтернативно решение на цялата задача
-- facts = 1 : helper 1 1
--   where helper i previous = current : helper (i + 1) current
--           where current = i * previous