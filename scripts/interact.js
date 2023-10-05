const { ethers, JsonRpcProvider} = require("ethers");   // use ethers to interact with sepolia testnet
var BigNumber = require('bignumber.js');                // npm i bignumber.js@4.0.4
                                                        // don't use 10^2 for calculation use: new BigNumber(base).pow(exponential))

require("dotenv").config();                             // import .env variables
var fs = require('fs');                                 // used to write to file


const { API_URL, PRIVATE_KEY} = process.env;            // get objects to represent .env vars

// Get contract abi
var jsonFile = "./artifacts/contracts/DataConsumerV3.sol/DataConsumerV3.json";
var parsed= JSON.parse(fs.readFileSync(jsonFile));
var abi = parsed.abi;

// FILL IN the address of the consumer contract which will provide the price of ETH on sepolia
const addr = ''; //

const getDataFeeds = async () => {
  //  ************* Group into function *********************

    const provider = new JsonRpcProvider(API_URL);            // use testnet api key to get provider
    const signer = new ethers.Wallet(PRIVATE_KEY, provider);  // use private key from metamask wallet to sign

    // Create an instance of the contract which we can interact with
    const priceFeed = new ethers.Contract(addr, abi, signer);

    // returns priceFeed
  //  *******************************************************


  
   // Get the data from the last round of the contract
    // add and get decimals
    const tx = await priceFeed.addDecimals();
    const receipt = await tx.wait();
    const decimals = await priceFeed.viewDecimals();

    // add and get descriptions
    const tx2 = await priceFeed.addDescription();
    const receipt2 = await tx2.wait();
    const descriptions = await priceFeed.viewDescription();

    // add and get prices
    const tx3 = await priceFeed.addPrice();
    const receipt3 = await tx3.wait();
    const prices = await priceFeed.viewPrice();


    //  ************* Group into function *********************
    // parameters: decimals, descriptions, prices

    // create json object to write data to
    var DataFeeds = {
      price_feeds: [],
      tx_receipts: []
    };

  // uncomment to see receipts
    // DataFeeds.tx_receipts.push(receipt);
    // DataFeeds.tx_receipts.push(receipt2);
    // DataFeeds.tx_receipts.push(receipt3);

    

    if (decimals.length == descriptions.length && descriptions.length == prices.length) { // then we can safely iterate thru arrays in single loop
      // iterate through arrays to create json object
      for (let i = 0; i < decimals.length; i++) { // arbitrarily picked deciamls to iterate thru
        let price = Number(BigInt(prices[i]));
        let decimal = Number(BigInt(decimals[i]));

        let value = new BigNumber(price);
        let divisor = new BigNumber(10).pow(decimal); // obtain decimal for particular feed

        let result;

        result = value.dividedBy(divisor); // convert to be readable

    // uncomment code below if you want percetages in the rates
        // let substrings = ["Rate", "APR", "Volatility"];
        // let percentage;
        // // handle rates and decimals
        // if (substrings.some(sub => descriptions[i].includes(sub))){//(descriptions[i].search("Rate") !== -1) {  // if APR in description then multiply by 100 to get percentage
        //   let num = new BigNumber(10).pow(2);
        //   percentage = (result * num);
        //   result = parseFloat(percentage.toFixed(5));
        // }

        let jsonObject = {
          id: i,
          description: descriptions[i],
          decimals: decimal,
          price: result.toString()
      };

      DataFeeds.price_feeds.push(jsonObject)

    }
    // return DataFeeds
  //  *******************************************************


      console.log(DataFeeds);

  //  ************* Group into function *********************
  // parameters: DataFeeds
      var fs = require('fs');
      fs.writeFile('data/data_feeds.json', JSON.stringify(DataFeeds), 'utf8', callback);

      priceFeed.clearArray();
    } else {
      console.log("One of the arrays is not expected length. Automatically clearing contract array data and running again");
      priceFeed.clearArray();
    }
  //  *******************************************************
}

function callback(){
  return
}

getDataFeeds().catch((e) => {
    console.error(e);
    process.exit(1);
});

// code in case you need to convert
//        // let substrings = ["Rate", "APR", "Volatility"];

        // // comment out below if statement if you don't want percentages and only keep the else statement
        // // handle rates and decimals
        // if (substrings.some(sub => descriptions[i].includes(sub))){//(descriptions[i].search("Rate") !== -1) {  // if APR in description then multiply by 100 to get percentage
        //   let num = new BigNumber(10).pow(2);
        //   result = (conversion * num);
        //   result = parseFloat(result.toFixed(5));
        // }