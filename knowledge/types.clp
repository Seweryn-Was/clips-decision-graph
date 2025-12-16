(deftemplate state
  (slot current))

(deftemplate edge
  (slot from)
  (slot opt-id)
  (slot to))

(deftemplate result
  (slot id)
  (slot title)
  (slot desc))

(deftemplate ui-ask
  (slot node-id))

(deftemplate ui-answer
  (slot node-id)
  (slot opt-id))

(deftemplate ui-result
  (slot result-id))
