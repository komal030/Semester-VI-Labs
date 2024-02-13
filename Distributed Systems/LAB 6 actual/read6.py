import sys

max_confirmed_cases_per_country = {}

for line in sys.stdin:
    # Split the line by tab
    country_region, confirmed_cases_str = line.strip().split("\t")
    
    # Convert confirmed cases to integer
    confirmed_cases = int(confirmed_cases_str)
    
    # Update max confirmed cases for each country/region
    if country_region in max_confirmed_cases_per_country:
        max_confirmed_cases_per_country[country_region] = max(max_confirmed_cases_per_country[country_region], confirmed_cases)
    else:
        max_confirmed_cases_per_country[country_region] = confirmed_cases

# Output the results
for country_region, max_cases in max_confirmed_cases_per_country.items():
    print(f"{country_region}\t{max_cases}")

