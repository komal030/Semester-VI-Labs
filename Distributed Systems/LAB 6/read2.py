import sys

max_cost_per_location = {}

for line in sys.stdin:
    location, cost = line.strip().split("\t")
    cost = float(cost)
    if location in max_cost_per_location:
        max_cost_per_location[location] = max(max_cost_per_location[location], cost)
    else:
        max_cost_per_location[location] = cost

for location, max_cost in max_cost_per_location.items():
    print(f"{location}\t{max_cost}")
