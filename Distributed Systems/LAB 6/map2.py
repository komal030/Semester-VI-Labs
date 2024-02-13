'''cat example.txt | python3 mapper.py | sort | python3 reducer.py'''
import sys
for line in sys.stdin:
    data = line.strip().split("\t")
    if len(data) == 6:
        _, _, location, _, cost, _ = data
        print(f"{location}\t{cost}")
