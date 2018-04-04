import Prelude hiding (head, tail, lookup)

data Tree a = Leaf a | Node (Tree a) (Tree a)
data Digit a = One (Tree a) | Two (Tree a) (Tree a) | Two' (Tree a) (Tree a) | Three (Tree a) (Tree a) (Tree a)
type Schedule a = [[Digit a]]
type RList a = ([Digit a], Schedule a)

empty :: RList a
empty = ([], [])

exec :: Schedule a -> Schedule a
exec [] = []
exec ((Two' _ _ : job) : sched) = job : sched
exec (_ : sched) = sched

consTree :: Tree a -> [Digit a] -> [Digit a]
consTree t [] = [One t]
consTree t (One t1 : ds) = Two t t1 : ds
consTree t (Two t1 t2 : ds) = Three t t1 t2 : ds
consTree t (Two' t1 t2 : ds) = Three t t1 t2 : ds
consTree t (Three t1 t2 t3 : ds) = Two' t t1 : consTree (Node t2 t3) ds

cons :: a -> RList a -> RList a
cons x (ds, sched) = sched' `seq` (ds', sched')
  where
  ds' = consTree (Leaf x) ds
  sched' = exec (exec (ds' : sched))

unconsTree :: [Digit a] -> (Tree a, [Digit a])
unconsTree [] = error "empty list"
unconsTree [One t] = (t, [])
unconsTree (Two t t1 : ds) = (t, One t1 : ds)
unconsTree (Two' t t1 : ds) = (t, One t1 : ds)
unconsTree (Three t t1 t2 : ds) = (t, Two t1 t2 : ds)
unconsTree (One t : ds) =  (t, Two' t1 t2 : ds')
  where (Node t1 t2, ds') = unconsTree ds

head :: RList a -> a
head (ds, _) = x
  where (Leaf x, _) = unconsTree ds

tail :: RList a -> RList a
tail (ds, sched) = sched' `seq` (ds', sched')
  where
  (_, ds') = unconsTree ds
  sched' = exec (exec (ds' : sched))
