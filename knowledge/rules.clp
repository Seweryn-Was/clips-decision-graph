(defrule ask-current
  (state (current ?nid))
  (not (ui-ask (node-id ?nid)))
  (not (ui-result (result-id ?nid)))
=>
  (assert (ui-ask (node-id ?nid))))

(defrule advance
  ?s <- (state (current ?nid))
  ?a <- (ui-answer (node-id ?nid) (opt-id ?oid))
  ?q <- (ui-ask (node-id ?nid))
  (edge (from ?nid) (opt-id ?oid) (to ?next))
=>
  (retract ?a ?q)
  (modify ?s (current ?next)))

(defrule emit-result
  (state (current ?rid))
  (result (id ?rid))
  (not (ui-result (result-id ?rid)))
=>
  (assert (ui-result (result-id ?rid))))