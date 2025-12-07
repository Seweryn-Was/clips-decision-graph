; ---------- TEMPLATES ----------

(deftemplate node
  (slot id)
  (slot type) ; question / destination
)

(deftemplate transition
  (slot from)
  (slot answer)
  (slot to)
)

(deftemplate user-answer
  (slot question-id)
  (slot value)
)

(deftemplate current-node
  (slot id)
)

(deftemplate pending-question
  (slot id)
)

(deftemplate recommendation
  (slot planet)
)
