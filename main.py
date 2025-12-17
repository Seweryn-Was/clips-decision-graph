from dataclasses import dataclass
from typing import List, Optional, Tuple

from flask import Flask, request, redirect, url_for, session, render_template_string
from clips import Environment

CLIPS_FILE = "rules.clp"
SECRET_KEY = "dev-secret"

app = Flask(__name__)
app.secret_key = SECRET_KEY

@dataclass
class QuestionState:
    text: str
    qid: str
    options: List[str]

@dataclass
class AnswerState:
    text: str

def build_env_and_replay(history: List[Tuple[str, str]]) -> Environment:
    env = Environment()
    env.load(CLIPS_FILE)
    env.reset()
    env.run()

    for qid, choice in history:
        env.assert_string(f'({qid} "{choice}")')
        env.run()

    return env

def get_fact(env: Environment, template_name: str):
    for f in env.facts():
        if f.template.name == template_name:
            return f
    return None

def read_state(env: Environment) -> Tuple[Optional[QuestionState], Optional[AnswerState]]:
    ans = get_fact(env, "odpowiedz")
    if ans is not None:
        return None, AnswerState(text=str(ans[0]))

    q = get_fact(env, "pytanie")
    if q is None:
        return None, None

    text = str(q[0])
    qid = str(q[1])
    options = [str(x) for x in list(q)[2:]]
    return QuestionState(text=text, qid=qid, options=options), None

PAGE = """
<!doctype html>
<html lang="pl">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>CLIPS Decision Graph</title>
  <style>
    body { font-family: system-ui, -apple-system, Segoe UI, Roboto, Arial, sans-serif; margin: 0; background: #0b1020; color: #e6e8ef; }
    .wrap { max-width: 1100px; margin: 0 auto; padding: 24px; }
    .grid { display: grid; grid-template-columns: 360px 1fr; gap: 18px; }
    .card { background: #121a33; border: 1px solid #22305f; border-radius: 14px; padding: 16px; }
    h1 { margin: 0 0 12px; font-size: 22px; }
    h2 { margin: 0 0 10px; font-size: 18px; color: #cfd6ff; }
    .q { font-size: 18px; line-height: 1.35; text-align: center; padding: 14px 10px; }
    .btn { width: 100%; padding: 12px 14px; margin: 8px 0; border-radius: 12px; border: 1px solid #2b3a74;
           background: #1a2550; color: #eef0ff; font-size: 16px; cursor: pointer; }
    .btn:hover { background: #22306a; }
    .muted { color: #9aa6d6; font-size: 13px; }
    .row { display: flex; gap: 10px; }
    .smallbtn { flex: 1; padding: 10px 12px; border-radius: 12px; border: 1px solid #2b3a74; background: #101a3f; color: #eef0ff; cursor: pointer; }
    pre { white-space: pre-wrap; word-break: break-word; margin: 0; font-size: 13px; color: #b9c2ee; }
    a { color: #b9c2ee; }
    @media (max-width: 900px) { .grid { grid-template-columns: 1fr; } }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>CLIPS Decision Graph</h1>

    <div class="grid">
      <div class="card">
        <h2>Historia</h2>
        <div class="row" style="margin: 10px 0 14px;">
          <form method="post" action="{{ url_for('restart') }}" style="flex:1;">
            <button class="smallbtn" type="submit">Restart</button>
          </form>
          <form method="post" action="{{ url_for('debug') }}" style="flex:1;">
            <button class="smallbtn" type="submit">Debug facts</button>
          </form>
        </div>

        {% if history %}
          <pre>{% for qid, choice in history %}{{ qid }}: {{ choice }}
{% endfor %}</pre>
        {% else %}
          <div class="muted">Brak odpowiedzi jeszcze.</div>
        {% endif %}
      </div>

      <div class="card">
        <h2>Pytanie</h2>

        {% if answer %}
          <div class="q">{{ answer.text }}</div>
          <form method="post" action="{{ url_for('restart') }}">
            <button class="btn" type="submit">Zacznij od nowa</button>
          </form>

        {% elif question %}
          <div class="q">{{ question.text }}</div>

          {% for opt in question.options %}
            <form method="post" action="{{ url_for('choose') }}">
              <input type="hidden" name="qid" value="{{ question.qid }}" />
              <input type="hidden" name="choice" value="{{ opt }}" />
              <button class="btn" type="submit">{{ opt }}</button>
            </form>
          {% endfor %}

          <div class="muted" style="margin-top: 10px;">qid: {{ question.qid }}</div>

        {% else %}
          <div class="q">Brak faktu (pytanie ...) i brak (odpowiedz ...). Sprawdź reguły.</div>
        {% endif %}

        {% if debug_facts %}
          <hr style="border: none; border-top: 1px solid #22305f; margin: 16px 0;">
          <div class="muted">Facts:</div>
          <pre>{{ debug_facts }}</pre>
        {% endif %}
      </div>
    </div>
  </div>
</body>
</html>
"""

def get_history() -> List[Tuple[str, str]]:
    raw = session.get("history", [])
    out: List[Tuple[str, str]] = []
    for item in raw:
        if isinstance(item, list) and len(item) == 2:
            out.append((str(item[0]), str(item[1])))
    return out

def set_history(history: List[Tuple[str, str]]) -> None:
    session["history"] = [[qid, choice] for qid, choice in history]

@app.get("/")
def index():
    history = get_history()
    env = build_env_and_replay(history)
    question, answer = read_state(env)

    return render_template_string(
        PAGE,
        history=history,
        question=question,
        answer=answer,
        debug_facts=None,
    )

@app.post("/choose")
def choose():
    qid = request.form.get("qid", "").strip()
    choice = request.form.get("choice", "").strip()

    if not qid or not choice:
        return redirect(url_for("index"))

    history = get_history()
    history.append((qid, choice))
    set_history(history)
    return redirect(url_for("index"))

@app.post("/restart")
def restart():
    session.pop("history", None)
    return redirect(url_for("index"))

@app.post("/debug")
def debug():
    history = get_history()
    env = build_env_and_replay(history)
    facts = "\n".join(str(f) for f in env.facts())

    question, answer = read_state(env)
    return render_template_string(
        PAGE,
        history=history,
        question=question,
        answer=answer,
        debug_facts=facts if facts else "(brak faktów)",
    )

if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000, debug=True)
