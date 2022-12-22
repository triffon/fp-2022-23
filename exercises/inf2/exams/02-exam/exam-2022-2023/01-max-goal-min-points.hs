-- Резултат от футболна среща се представя с наредена четворка от два низа,
-- представляващи имената на играещите отбори, и две естествени числа,
-- представляващи отбелязаните голове от съответните отбори.
-- При победа отбор получава 3 т., при равен мач – 1 т., а при загуба – 0 т.
-- Футболен турнир се представя като списък от резултати от отделните срещи в него. 
-- Голова разлика на отбор наричаме разликата на общия брой отбелязани голове и
-- общия брой получени голове в турнира. 

-- а). Да се реализира функция maxGoalMinPoints,
-- която измежду отборите с максимална голова разлика намира такъв с най-малко получени точки. 

calculateGoalDifference team tournament =
  sum $ map getDifference tournament
  where getDifference (name1, name2, goals1, goals2)
          | team == name1 = goals1 - goals2
          | team == name2 = goals2 - goals1
          | otherwise = 0

calculatePoints team tournament =
  sum $ map getPoints tournament
  where getPoints (name1, name2, goals1, goals2)
          | team == name1 && goals1 > goals2 = 3
          | team == name2 && goals2 > goals1 = 3
          | team == name1 && goals1 == goals2 = 1
          | team == name2 && goals2 == goals1 = 1
          | otherwise = 0

unique [] = []
unique (x:xs) = x : unique (filter (/= x) xs)

getTeams tournament =
  unique $ concatMap (\(name1, name2, _, _) -> [name1, name2]) tournament

maxGoalMinPoints tournament =
  head $ map fst $ filter (\(team, points) -> points == minPoints) points
  where
    goalDifferences = map (\team -> (team, calculateGoalDifference team tournament)) (getTeams tournament)
    maxGoalDifference = maximum $ map snd goalDifferences
    maxGoalDifferenceTeams = map fst $ filter ((== maxGoalDifference) . snd) goalDifferences
    points = map (\team -> (team, calculatePoints team tournament)) maxGoalDifferenceTeams
    minPoints = minimum $ map snd points

tournament = [("A","B",1,0),("B","C",4,1),("C","B",3,3),("B","A",1,2),("A","C",0,1)] 
-- maxGoalMinPoints tournament -- => "B" (голова разлика: 8 – 7 = 1, точки: 4) 

-- б). Казваме, че отбор А превъзхожда отбор Б ако го е победил във всичките им директни срещи 
-- или е победил в поне една среща отбор В, който превъзхожда отбор Б.
-- Да се реализира функция surpassSelf, която намира всички отбори в даден турнир, 
-- които превъзхождат себе си. 

winsOver team1 team2 (name1, name2, goals1, goals2) =
  team1 == name1 && team2 == name2 && goals1 > goals2 ||
  team1 == name2 && team2 == name1 && goals2 > goals1

winsAll team1 team2 tournament =
  (not $ null relevantGames) &&
  (all (\game -> winsOver team1 team2 game) relevantGames)
  where
    relevantGames =
      filter
        (\(name1, name2,_,_) ->
          team1 == name1 && team2 == name2 ||  team1 == name2 && team2 == name1)
        tournament

winsAny team1 team2 tournament =
  any (\game -> winsOver team1 team2 game) tournament

surpassSelf tournament =
  filter surpassSelfHelper teams
  where
    teams = getTeams tournament
    surpassSelfHelper team =
      helper $ filter (\t -> winsAll t team tournament) teams
        where
          -- TODO: проверка за цикли
          helper result = result /= next result && ((team `elem` result) || (helper $ next result))
          next result =
            unique $ concatMap (\t -> filter (\t2 -> winsAny t2 t tournament) teams) result
  
-- surpassSelf tournament -- => ["A","B"]