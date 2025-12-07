; ---------- RULES ----------

(defrule ask-question
  ?c <- (current-node (id ?nid))
  (node (id ?nid) (type question))
  (not (user-answer (question-id ?nid)))
  =>
  (assert (pending-question (id ?nid)))
)

(defrule move-to-next-node
  ?c <- (current-node (id ?nid))
  (node (id ?nid) (type question))
  (user-answer (question-id ?nid) (value ?val))
  (transition (from ?nid) (answer ?val) (to ?next))
  =>
  (retract ?c)
  (assert (current-node (id ?next)))
)

(defrule make-recommendation
  (current-node (id ?nid))
  (node (id ?nid) (type destination))
  =>
  (assert (recommendation (planet ?nid)))
)

(defrule clear-pending-question
  ?pq <- (pending-question (id ?nid))
  (user-answer (question-id ?nid))
  =>
  (retract ?pq)
)