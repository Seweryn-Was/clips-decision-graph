import json
import os
import clips

BASE_DIR = os.path.dirname(os.path.dirname(__file__))
KNOW_DIR = os.path.join(BASE_DIR, "knowledge")
RES_DIR = os.path.join(BASE_DIR, "resources")


def load_json(name: str):
    with open(os.path.join(RES_DIR, name), encoding="utf-8") as f:
        return json.load(f)


def get_facts(env, template_name: str):
    return [f for f in env.facts() if f.template.name == template_name]


def main():
    questions = load_json("questions_pl.json")
    planets = load_json("planets_pl.json")

    env = clips.Environment()
    env.load(os.path.join(KNOW_DIR, "types.clp"))
    env.load(os.path.join(KNOW_DIR, "rules.clp"))
    env.load(os.path.join(KNOW_DIR, "graph.clp"))
    env.reset()

    while True:
        env.run()

        # check recomendation
        recs = get_facts(env, "recommendation")
        if recs:
            planet_id = recs[0]["planet"]
            info = planets.get(planet_id, {"name": planet_id, "description": ""})
            print("\n=== Twoja destynacja ===")
            print(info["name"])
            if info.get("description"):
                print(info["description"])
            break

        # check for question
        pendings = get_facts(env, "pending-question")
        if not pendings:
            print("Brak pytań i brak rekomendacji – coś poszło nie tak.")
            break

        q_fact = pendings[0]
        q_id = q_fact["id"]

        q_data = questions[q_id]
        options = q_data["options"]

        print("\n" + q_data["text"])
        keys = list(options.keys())
        for idx, key in enumerate(keys, start=1):
            print(f"  {idx}. {options[key]}")

        # get user answer
        choice_idx = None
        while choice_idx is None:
            raw = input("Wybierz opcję (numer): ").strip()
            if raw.isdigit():
                i = int(raw)
                if 1 <= i <= len(keys):
                    choice_idx = i
                else:
                    print("Nieprawidłowy numer.")
            else:
                print("Podaj numer opcji.")

        value_symbol = keys[choice_idx - 1]

        fact_str = f"(user-answer (question-id {q_id}) (value {value_symbol}))"
        env.assert_string(fact_str)

    print("\nKoniec.")


if __name__ == "__main__":
    main()
