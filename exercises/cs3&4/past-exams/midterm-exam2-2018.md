**Задача 1.** Да се напише функция **mostFrequent**, която по даден списък от списъци от числа връща числото, което е
сред най-често срещаните числа във всички списъци, ако такова има, или 0 иначе.
```haskell
mostFrequent [[1,1,3,2],[1,1,5],[1,5],[1,1,1,3]] → 1
mostFrequent [[1,1,3,2],[1,5,5],[1,5],[1,1,1,3]] → 0
```

**Задача 2.**

а) Да се напише функция **grow t x**, която по дадено двоично дърво от числа **t** получава ново, в което към всяко
листо на **t** добавя по две нови листа със зададена стойност **x**.

б) Двоично дърво наричаме “пълно”, ако има **2^n** елемента на ниво **n**. Да се напише функция **growingTrees**, която
генерира безкраен поток от пълни дървета с височини съответно 1, 2, 3,..., като всички елементи на ниво **n** са със
стойност **n**.

**Задача 3.** Телевизионно предаване се представя с наредена тройка от име (низ), начален час (наредена двойка от час и
минути) и продължителност (брой минути). Телевизионна програма наричаме последователност от предавания, чиито интервали
на излъчвания са подредени в нарастващ ред и не се пресичат.

а) Да се напише ункция **lastShow**, което по списък от предавания връща името на това, което завършва най-късно.

б) Да се напише функция **longestProgram**, която по даден списък от предавания генерира възможно най-дълга
телевизионна програма, т.е. сумата от продължителностите на предаванията в нея е максимална.
```haskell
shows = [(“A”, (11, 0), 120), (“B”, (12, 0), 15), (“C”, (10, 30), 90)]
lastShow shows → “B” longestProgram shows → [(“A”, (11, 0), 120))]
```
