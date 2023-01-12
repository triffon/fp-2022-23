data Person =
  Person { firstName :: String,        
           lastName :: String,
           age :: Int  
         } deriving (Eq, Show, Read) 

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday   
           deriving (Eq, Ord, Enum, Show, Read)  