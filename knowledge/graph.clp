; ---------- GRAPH DEFINITION ----------

(deffacts starwars-graph-no-attr

  ; questions
  (node (id q-start)   (type question))
  (node (id q-budget)  (type question))
  (node (id q-climate) (type question))

  ; destinations
  (node (id dest-endor)    (type destination))
  (node (id dest-naboo)    (type destination))
  (node (id dest-mustafar) (type destination))

  ; transition from q-start
  (transition (from q-start) (answer want-adventure) (to q-budget))
  (transition (from q-start) (answer want-relax)     (to q-climate))

  ; transition from q-budget
  (transition (from q-budget) (answer budget-low)  (to dest-endor))
  (transition (from q-budget) (answer budget-high) (to dest-mustafar))

  ; transition from q-climate
  (transition (from q-climate) (answer climate-warm) (to dest-naboo))
  (transition (from q-climate) (answer climate-hot)  (to dest-mustafar))

  ; starting point
  (current-node (id q-start))
)
