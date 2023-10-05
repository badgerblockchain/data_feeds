// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


// import "@openzeppelin/contracts/DataConsumer.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


/**
 * THIS IS AN EXAMPLE CONTRACT THAT USES HARDCODED
 * VALUES FOR CLARITY.
 * THIS IS AN EXAMPLE CONTRACT THAT USES UN-AUDITED CODE.
 * DO NOT USE THIS CODE IN PRODUCTION.
 */


// library UserLibrary {
//     struct returnData{
//         uint80 round;
//         int answer;
//         uint start;
//         uint time;
//         uint80 answerRound;
//     }
// }

/**
 * If you are reading data feeds on L2 networks, you must
 * check the latest answer from the L2 Sequencer Uptime
 * Feed to ensure that the data is accurate in the event
 * of an L2 sequencer outage. See the
 * https://docs.chain.link/data-feeds/l2-sequencer-feeds
 * page for details.
 */

contract backup {

    // AggregatorV3Interface internal dataFeed;

    AggregatorV3Interface[] public dataFeeds;

    // uint
    // string[] public description_data;
    // int[] public converted_data;

    // when should events be emitted?
  //  event LogAggregatorLoop(AggregatorV3Interface dataFeed, uint key);

    // TODO 
    // - Create a mapped network of data aggregators with BTC, ETH, LINK, 
    // - Create efficient well spaced out data structures to limit gas consumption
    // - Read data in a timer that is limited so it will not waste gas for unncessary calls



    /**
     * Network: Sepolia
     * Aggregator: ETH/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     * Network: Sepolia
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     * Aggregator: LINK/USD
     * Address: 0xc59E3633BAAC79493d908e63626716e204A45EdF

     */
    constructor() {
        addDataAggregator(0x694AA1769357215DE4FAC081bf1f309aDC325306); // ETH/USD
        addDataAggregator(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43); // BTC/USD
        addDataAggregator(0xc59E3633BAAC79493d908e63626716e204A45EdF); // LINK/USD
    }

    function addDataAggregator(address data_link) private {
        dataFeeds.push(AggregatorV3Interface(data_link)); 
    }

    function countDataAggregators() public view returns (uint) {
        return dataFeeds.length;
    }

    function decimalsETH() public view returns (uint) { // all have the same decimal
        return dataFeeds[0].decimals();
    }
    function decimalsBTC() public view returns (uint) { // all have the same decimal
        return dataFeeds[1].decimals();
    }
    function decimalsLINK() public view returns (uint) { // all have the same decimal
        return dataFeeds[2].decimals();
    }

    function getDescriptionETH() external view returns (string memory){
        return dataFeeds[0].description();
    }
    function getDescriptionBTC() external view returns (string memory){
        return dataFeeds[1].description();
    }
    function getDescriptionLINK() external view returns (string memory){
        return dataFeeds[2].description();
    }

    function getLatestDataETH() public view returns (int) {
        (
           /* uint80 roundID*/,
            int unconvertedPrice,
           /* uint startedAt*/,
           /* uint timeStamp8?,
            /*uint80 answeredInRound*/,
        ) = dataFeeds[0].latestRoundData();
        uint8 tokenDecimals = dataFeeds[0].decimals();
        int256 convertedPrice = unconvertedPrice / int256(10 ** uint256(tokenDecimals)); // convert to human readable
        return convertedPrice;
    }
    function getLatestDataBTC() public view returns (int) {
        (
           /* uint80 roundID*/,
            int unconvertedPrice,
           /* uint startedAt*/,
           /* uint timeStamp8?,
            /*uint80 answeredInRound*/,
        ) = dataFeeds[1].latestRoundData();
        uint8 tokenDecimals = dataFeeds[1].decimals();
        int256 convertedPrice = unconvertedPrice / int256(10 ** uint256(tokenDecimals)); // convert to human readable
        return convertedPrice;
    }

    function getLatestDataLINK() public view returns (int) {
        (
           /* uint80 roundID*/,
            int unconvertedPrice,
           /* uint startedAt*/,
           /* uint timeStamp8?,
            /*uint80 answeredInRound*/,
        ) = dataFeeds[2].latestRoundData();
        uint8 tokenDecimals = dataFeeds[2].decimals();
        int256 convertedPrice = unconvertedPrice / int256(10 ** uint256(tokenDecimals)); // convert to human readable
        return convertedPrice;
    }

}


// /**
//  * If you are reading data feeds on L2 networks, you must
//  * check the latest answer from the L2 Sequencer Uptime
//  * Feed to ensure that the data is accurate in the event
//  * of an L2 sequencer outage. See the
//  * https://docs.chain.link/data-feeds/l2-sequencer-feeds
//  * page for details.
//  */

// contract DataConsumerV3 {

//     AggregatorV3Interface[] public dataFeeds;

//     // Array of aggregators

//     // TODO 
//     // - Create a mapped network of data aggregators with BTC, ETH, LINK, 
//     // - Create efficient well spaced out data structures to limit gas consumption
//     // - Read data in a timer that is limited so it will not waste gas for unncessary calls



//     /**
//      * Network: Sepolia
//      * Aggregator: ETH/USD
//      * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
//      * Network: Sepolia
//      * Aggregator: BTC/USD
//      * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
//      * Aggregator: LINK/USD
//      * Address: 0xc59E3633BAAC79493d908e63626716e204A45EdF

//      */
//     constructor() {
//         addDataAggregator(0x694AA1769357215DE4FAC081bf1f309aDC325306); // ETH/USD
//         addDataAggregator(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43); // BTC/USD
//         addDataAggregator(0xc59E3633BAAC79493d908e63626716e204A45EdF); // LINK/USD
//     }

//     function addDataAggregator(address data_link) private {
//         dataFeeds.push(AggregatorV3Interface(data_link)); 
//     }

//     function countDataAggregators() public view returns (uint) {
//         return dataFeeds.length;
//     }

//     // can be marked internal
//     // try not to waste space -> smaller than uint8?
//     function decimals() external view returns (uint8){
//         return dataFeeds[0].decimals();
//     }

//     // function getDescription() public returns (string[] memory) {
//     //     uint key = 1;
//     //     AggregatorOperationLoop(key);
//     //     return description_data;
//     // }

//     // // view means read only
//     // function convertPrice() public returns (int[] memory) {
//     //     uint key = 2;
//     //     AggregatorOperationLoop(key);
//     //     return converted_data;

//     //     // (
//     //     //    /* uint80 roundID*/,
//     //     //     int unconvertedPrice,
//     //     //    /* uint startedAt*/,
//     //     //    /* uint timeStamp8?,
//     //     //     /*uint80 answeredInRound*/,
//     //     // ) = dataFeeds[0].latestRoundData();
//     //     // uint8 tokenDecimals = dataFeeds[0].decimals();
//     //     // int256 convertedPrice = unconvertedPrice / int256(10 ** uint256(tokenDecimals)); // convert to human readable
//     //     // return convertedPrice;
//     // }

//     // // function getRoundData() public view returns(int){
//     // //     AggregatorOperationLoop("get_round_data");
//     // //     return description_data;
//     // // }



//     // /**
//     //  * Returns the latest rounded answer.
//     //  */
//     // function getLatestData() public view returns (int) {
//     //     // prettier-ignore
//     //     // (
//     //     //     uint80 roundID,
//     //     //     int unconvertedPrice,
//     //     //     uint startedAt,
//     //     //     uint timeStamp8,
//     //     //     uint80 answeredInRound,
//     //     // ) = dataFeeds[0].latestRoundData();

//     //     // return (roundID,unconvertedPrice,startedAt,timeStamp8,answeredInRound);
//     // }

//     // //     // iterate through and emit data
//     // // function AggregatorLoopUint8(uint8 current_feed, string type_) private {
//     // //     for (uint i=0; i<current_feed.length; i++) {
//     // //         emit LogAggregatorLoop(current_feed[i], type_);
//     // //     }
//     // // }
    
//     // function AggregatorOperationLoop(uint key) public {
//     //    // console.log("This is a message");
//     //     for (uint i=0; i<dataFeeds.length; i++) {
//     //         if (key == 0) {
//     //             uint8 num;
//     //             AggregatorV3Interface feed = dataFeeds[i];
//     //             num = feed.decimals();
//     //             decimal_data.push(num);
//     //             // do something
//     //         }// else if (key == 1) {
//     //         //     string memory descrip;
//     //         //     descrip = dataFeeds[i].description();
//     //         //     description_data.push(descrip);
//     //         //     // do something else
//     //         // } else if (key == 2) {
//     //         //     (
//     //         //     /* uint80 roundID*/,
//     //         //         int unconvertedPrice,
//     //         //     /* uint startedAt*/,
//     //         //     /* uint timeStamp8?,
//     //         //         /*uint80 answeredInRound*/,
//     //         //     ) = dataFeeds[0].latestRoundData();
//     //         //     uint8 tokenDecimals = dataFeeds[i].decimals();
//     //         //     int256 convertedPrice = unconvertedPrice / int256(10 ** uint256(tokenDecimals)); // convert to human readable
//     //         //     converted_data.push(convertedPrice);
//     //         //     // do something else
//     //         // } else if (key == 3){

//     //         // } else {
//     //             // default action
//     //        // }
//     //      //   emit LogAggregatorLoop(dataFeeds[i], key);
//     //     }
//    // }

// }
