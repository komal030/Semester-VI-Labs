'''cat covid_19_data.txt | python3 map6.py | sort | python3 read6.py'''
import sys
for line in sys.stdin:
    # Split the line by comma
    data = line.strip().split(",")
    
    # Skip the header line
    if data[0] == "SNo":
        continue
    
    # Extract Country/Region and Confirmed cases
    country_region = data[3]  # Index 3 corresponds to Country/Region
    confirmed_cases_str = data[5]  # Index 5 corresponds to Confirmed cases
    
    # Check if confirmed cases is a valid integer
    try:
        confirmed_cases = int(confirmed_cases_str)
        # Emit key-value pair
        print(f"{country_region}\t{confirmed_cases}")
    except ValueError:
        # Skip the line if confirmed cases is not a valid integer
        continue

