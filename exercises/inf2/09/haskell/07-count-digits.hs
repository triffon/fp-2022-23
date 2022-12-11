countDigits number =
  if number < 10
    then 1
    else 1 + (countDigits (number `div` 10))