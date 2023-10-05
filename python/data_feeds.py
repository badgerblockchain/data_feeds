import subprocess
import json
import pandas as pd


def main():

    result = subprocess.run(['node', './scripts/interact.js'], capture_output=True, text=True)

    # pull data from json
    with open('data/data_feeds.json', 'r') as file:
        data = json.load(file)

    print(data)

    # data frames not working aftering adding receipts
    df = pd.DataFrame(data)

    print(df)

    # TODO next: https://docs.chain.link/data-feeds/rates-feeds/addresses?network=ethereum&page=1
   # - Read data in a timer that is limited so it will not waste gas for unncessary calls

    # create a script that runs daily to compare the prices
    # 
    # https://medium.com/coinmonks/trust-minimized-applications-part-1-chainlink-data-feeds-88ea98ca21b 

main()