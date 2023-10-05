# Data Feeds

Deploy a DataConsumerV3 to sepolia testnet and interact with javascript code to read the data and write to a json file.

Use python to interact with json file to anaylze data


## Setup .env file
In order to have the script work correctly you must configure your hardhat.config.js to interact with the sepolia testnet.

1. Create an alchemy url endpoint for the Sepolia testnet
2. Create .env file
   - API_URL = newly created Alchemy Sepolia URL key **string**
   - PRIVATE_KEY = wallet private key **string** (MAKE SURE TO use separate accounts: 1 for testing and another to store real money - if applicable) 

## Install dependencies
Run the following cmd to ensure all dependencies are integrated into your project
```shell
npm install
```

## Deploy the contract
The following script runs the deploy.js script that will deploy the DataConsumerV3 contract to the Sepolia Testnet
```shell
npx hardhat run scripts/deploy.js --network sepolia
```
Copy the outputed contract address and paste it into the addr variable in the interact.js file

## Using Data Feeds
The next cmd will call the newly created contract in order to get live data
```shell
node scripts/interact.js
```

## Integrating with python annd other enhancements
TODO
   - get historical data: https://docs.chain.link/data-feeds/historical-data
     - round if from latestRoundData() roundID field?
     - You can compare the data across these windows to infer whether the volatility of an asset is trending up or down.  For example, if realized volatility for the 24-hour window is higher than the 7-day window, volatility might increase
   - create model to train against historical data
   - use these functions to get rates on real time stock market data ... somehow
     - Use a trusted oracle source to give accurate stock price data (may not even work yet)
   - calculate historical volatility of crypto assest/stock

## Learn More
You can read through the following documentation to learn more
https://docs.chain.link/data-feeds