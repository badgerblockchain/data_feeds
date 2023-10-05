// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

/**
 * The following uses UNAUDITED CODE: DO NOT USE IN PRODUCTION
 * 
 * Deploys a DataConsumerV3 that interacts with Chainlink Data Aggregators to
 * obtain real time chain data
 */

contract DataConsumerV3 {

    AggregatorV3Interface[] public dataFeeds;
    uint8[] public decimals_data;
    string[] public description_data;
    int[] public price_data;

    // when should events be emitted?
    // event LogAggregatorLoop(AggregatorV3Interface dataFeed, uint key);

    // TODO 
    // - emit events
    // - Create a mapped network of data aggregators with BTC, ETH, LINK, (brainstorm better data structure perhaps to consume less gas)
    // - Create efficient well spaced out data structures to limit gas consumption
    // - add exceptions to not call if bad data
    

    /**
     * Links data feeds by calling the addDataAggregator method
     * 
     * Network: Sepolia
     * Aggregator: ETH/USD
     * Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
     * Aggregator: BTC/USD
     * Address: 0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43
     * Aggregator: LINK/USD
     * Address: 0xc59E3633BAAC79493d908e63626716e204A45EdF
     * Aggregator: 30 Day ETH APR
     * Address: 0xceA6Aa74E6A86a7f85B571Ce1C34f1A60B77CD29
     * Aggregator: 60 Day ETH APR
     * Address: 0x7422A64372f95F172962e2C0f371E0D9531DF276
     * Aggregator: BTC Interest Rate Benchmark Curve 1 Day
     * Address: 0x7DE89d879f581d0D56c5A7192BC9bDe3b7a9518e
     * Aggregator: BTC Interest Rate Benchmark Curve 2 Week
     * Address: 0x39545d0c11CD62d787bB971B6a802150e1f54D8f
     * Aggregator: BTC-USD 24hr Realized Volatility
     * Address: 0x28f9134a15cf0aAC9e1F0CD09E17f32925254C77
     * Aggregator: BTC-USD 30-Day Realized Volatility
     * Address: 0xabfe1e28F54Ac40776DfCf2dF0874D37254D5F59
     * Aggregator: ETH-USD 24hr Realized Volatility
     * Address: 0x31D04174D0e1643963b38d87f26b0675Bb7dC96e
     * Aggregator: ETH-USD 30-Day Realized Volatility
     * Address: 0x8e604308BD61d975bc6aE7903747785Db7dE97e2
     * Aggregator: LINK-USD 24hr Realized Volatility
     * Address: 0xfD59B51F25E0Ab790a4F0c483BaC194FA0479D29
     * Aggregator: LINK-USD 30-Day Realized Volatility
     * Address: 0xd599cEF88Bbd27F1392A544bD0F343ec8893124C
     * 
     */
    constructor() {
        addDataAggregator(0x694AA1769357215DE4FAC081bf1f309aDC325306); // ETH/USD
        addDataAggregator(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43); // BTC/USD
        addDataAggregator(0xc59E3633BAAC79493d908e63626716e204A45EdF); // LINK/USD
        addDataAggregator(0xceA6Aa74E6A86a7f85B571Ce1C34f1A60B77CD29); // ETH 30-day APR
        addDataAggregator(0x7422A64372f95F172962e2C0f371E0D9531DF276); // ETH 60-day APR
        addDataAggregator(0x7DE89d879f581d0D56c5A7192BC9bDe3b7a9518e); // BTC Interest Rate Benchmark Curve 1 Day
        addDataAggregator(0x39545d0c11CD62d787bB971B6a802150e1f54D8f); // BTC Interest Rate Benchmark Curve 2 Week
        addDataAggregator(0x28f9134a15cf0aAC9e1F0CD09E17f32925254C77); // BTC-USD 24hr Realized Volatility
        addDataAggregator(0xabfe1e28F54Ac40776DfCf2dF0874D37254D5F59); // BTC-USD 30-Day Realized Volatility
        addDataAggregator(0x31D04174D0e1643963b38d87f26b0675Bb7dC96e); // ETH-USD 24hr Realized Volatility
        addDataAggregator(0x8e604308BD61d975bc6aE7903747785Db7dE97e2); // ETH-USD 30-Day Realized Volatility
        addDataAggregator(0xfD59B51F25E0Ab790a4F0c483BaC194FA0479D29); // LINK-USD 24hr Realized Volatility
        addDataAggregator(0xd599cEF88Bbd27F1392A544bD0F343ec8893124C); // LINK-USD 30-Day Realized Volatility

        // ADD 7-day Volatility
    }

// TODO update function comments to have same format

    /**
    Creates a new instance of the AggregatorV3Interface whose API reference
    can be found at https://docs.chain.link/data-feeds/api-reference

    Parameters:
    -----------
    address: data_link
        Price feed contract addresses
            - https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1
     */
    function addDataAggregator(address data_link) private {
        dataFeeds.push(AggregatorV3Interface(data_link)); 
    }

    /**
     * Counts number of data aggregators initialzed in the constructor 
     * 
     * Returns:
     * --------
     * uint: dataFeeds.length
     *  Number of data feeds being tracked
     */
    function countDataAggregators() public view returns (uint) {
        return dataFeeds.length;
    }

    /**
    Adds decimals to the decimals array to keep track of decimal data

     */
    function addDecimals() public {
        AggregatorOperationLoop(0);
    }

    /**
    Returns an array of tracked decimals

    Returns:
    --------
    uint[]: decimals_data
        Decimals for the aggregators
     */
    function viewDecimals() public view returns (uint8[] memory) {
        return decimals_data;
    }

        /**
    Adds description to the description array to keep track of description data

     */
    function addDescription() public {
        AggregatorOperationLoop(1);
    }

    /**
    Returns an array of tracked descriptions

    Returns:
    --------
    string[]: decimals_data
        Description for the aggregators
     */
    function viewDescription() public view returns (string[] memory) {
        return description_data;
    }
    
    /**
     * Adds price to the price array to keep track of price data

     */
    function addPrice() public {
        AggregatorOperationLoop(2);
    }

    /**
    Returns an array of tracked prices

    Returns:
    --------
    int[]: price_data
        Price for the aggregators
     */
    function viewPrice() public view returns (int[] memory) {
        return price_data;
    }

    /**
    Assigns Aggregator data to appropriate array based on 
    the key sent

     */
    function AggregatorOperationLoop(uint key) private { // TODO if broken change back to public
        for (uint i=0; i<dataFeeds.length; i++) {
            if (key == 0) {
                uint8 num;
                num = dataFeeds[i].decimals();
                decimals_data.push(num);
            } else if (key == 1) {
                string memory descrip;
                descrip = dataFeeds[i].description();
                description_data.push(descrip);
            } else if (key == 2) {
            (
            /* uint80 roundID*/,
                int unconvertedPrice,
            /* uint startedAt*/,
            /* uint timeStamp8?,
                /*uint80 answeredInRound*/,
            ) = dataFeeds[i].latestRoundData();
            price_data.push(unconvertedPrice);
            }
        }
   }

    /**
    Removes all previously stored arrays
     */
   function clearArray() public {
        delete decimals_data;
        delete description_data;
        delete price_data;
    }
}