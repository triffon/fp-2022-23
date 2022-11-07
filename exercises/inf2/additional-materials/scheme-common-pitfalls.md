# Често срещани грешки при работа с DrRacket

### Искаме да използваме вградени в racket функции като filter, map, foldl

Проблем: Искаме да използваме вградената в racket функция `filter`, но получаваме `undefined identifier` грешка, защото всъщност използваме R5RS, а не racket (виж долу вляво).

![Undefined Identifier](./undefined-identifier.png)

Решение: Кликаме долу вляво -> Choose Language... -> The Racket Language. В началото на файла добавяме `#lang racket`.

![Undefined Identifier Fix](./undefined-identifier-fix.png)

![Undefined Identifier Fix Validation](./undefined-identifier-fix-validation.png)
