#!/usr/bin/env python3


def do_entrance(map_state):
    print("You are at the entrance. Choose a direction:")
    print("  1. Go into the hallway")
    print("  2. Go into the bathroom")
    print("  3. Go into the kitchen")

    finished = False
    while not finished:
        choice = input("Enter your choice: ")
        if choice == "1":
            map_state["room"] = "hallway"
            finished = True
        elif choice == "2":
            map_state["room"] = "bathroom"
            finished = True
        elif choice == "3":
            map_state["room"] = "kitchen"
            finished = True
        else:
            print("Invalid choice, try again")
        print(finished)


def do_hallway(map_state):
    print("You are at the hallway. Choose a direction:")
    print("  1. Go into the entrance")
    print("  2. Go into the bedroom")

    finished = False
    while not finished:
        choice = input("Enter your choice: ")
        if choice == "1":
            map_state["room"] = "hallway"
            finished = True
        elif choice == "2":
            map_state["room"] = "bathroom"
            finished = True
        elif choice == "3":
            map_state["room"] = "kitchen"
            finished = True
        else:
            print("Invalid choice, try again")


def map_example():

    map_state = {}
    map_state["room"] = "entrance"
    map_state["finished"] = False

    while not map_state["finished"]:
        if map_state["room"] == "entrance":
            do_entrance(map_state)
        elif map_state["room"] == "hallway":
            do_hallway(map_state)
        else:
            print(
                "Well this is awkward. "
                f"You've ended up in the room {map_state["room"]} "
                "which I haven't built yet."
            )
            map_state["finished"] = True


def main():
    map_example()


if __name__ == "__main__":
    main()
