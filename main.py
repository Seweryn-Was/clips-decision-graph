import json
import sys
from pathlib import Path
from clips import Environment


RULES_FILE = "knowledge/graph.clp"
TYPES_FILE = "knowledge/types.clp"
RESOURCES_FILE = "resources/questions.json"


def clips_escape(s: str) -> str:
    return s.replace("\\", "\\\\").replace('"', '\\"')


def assert_str(env: Environment, s: str) -> None:
    env.assert_string(s)


def find_one_fact(env: Environment, template_name: str):
    for f in env.facts():
        if f.template.name == template_name:
            return f
    return None


def load_graph_from_json(env: Environment, data: dict) -> None:
    """
    Inject graph into CLIPS:
    - (state (current ...))
    - edges from nodes/options
    - results
    """
    initial = data["initial_state"]
    assert_str(env, f"(state (current {initial}))")

    # edges: for each node, for each option => edge(from=node_id, opt-id=option_id, to=next)
    for node_id, node in data["nodes"].items():
        options = node.get("options", {})
        for opt_id, opt in options.items():
            nxt = opt["next"]
            assert_str(env, f"(edge (from {node_id}) (opt-id {opt_id}) (to {nxt}))")

    # results
    for rid, r in data["results"].items():
        title = clips_escape(r.get("title", ""))
        desc = clips_escape(r.get("desc", ""))
        assert_str(env, f'(result (id {rid}) (title "{title}") (desc "{desc}"))')


def get_question_from_json(data: dict, node_id: str) -> tuple[str, list[tuple[str, str]]]:
    """
    Returns:
      question_text, [(opt_id, opt_text), ...]
    """
    node = data["nodes"].get(node_id)
    if node is None:
        raise KeyError(f"Node '{node_id}' not found in JSON nodes")

    text = node["text"]
    opts = []
    for opt_id, opt in node["options"].items():
        opts.append((opt_id, opt["text"]))
    return text, opts


def main() -> int:
    res_path = Path(RESOURCES_FILE)
    if not res_path.exists():
        print(f"ERROR: missing {RESOURCES_FILE} next to main.py")
        return 1

    with res_path.open("r", encoding="utf-8") as f:
        data = json.load(f)

    env = Environment()
    env.load(RULES_FILE)
    env.load()
    env.reset()

    # inject graph
    load_graph_from_json(env, data)

    while True:
        env.run(50)

        # final result?
        rfact = find_one_fact(env, "ui-result")
        if rfact is not None:
            rid = str(rfact["result-id"])
            res = data["results"][rid]
            print("\n=== RESULT ===")
            print(res["title"])
            print()
            print(res["desc"])
            break

        # ask?
        ask = find_one_fact(env, "ui-ask")
        if ask is None:
            print("ERROR: No ui-ask and no ui-result. Graph may be incomplete.")
            return 2

        node_id = str(ask["node-id"])

        # if node_id points to a result directly, CLIPS should emit ui-result on next run
        if node_id in data["results"]:
            ask.retract()
            env.run(10)
            continue

        # fetch question/options from JSON
        q_text, opts = get_question_from_json(data, node_id)

        print("\n" + q_text)
        for i, (_, t) in enumerate(opts, start=1):
            print(f"  {i}. {t}")

        # get choice
        while True:
            raw = input("Choose option number: ").strip()
            try:
                idx = int(raw)
                if 1 <= idx <= len(opts):
                    break
            except ValueError:
                pass
            print("Invalid choice, try again.")

        opt_id = opts[idx - 1][0]

        assert_str(env, f"(ui-answer (node-id {node_id}) (opt-id {opt_id}))")

    env.clear()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
