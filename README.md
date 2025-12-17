# clips-decision-graph

A modular rule-based decision engine built using CLIPS and Python (clipspy),
implementing graph-driven inference and interactive dialog with the user.

The system represents decision logic as a directed graph of nodes and transitions,
and uses CLIPS rules to navigate through the graph based on user input.

## Python 

Project created on python version `3.13.7`

```
git clone https://github.com/Seweryn-Was/clips-decision-graph.git
cd clips-decision-graph
python3.13 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip -r requirements.txt
python main.py
```