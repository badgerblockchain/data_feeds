require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
const { API_URL, PRIVATE_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.21",
  networks: {
    hardhat: { // used to connect localhost hardhat node to metamask
      chainId: 1337,
    },
    sepolia: {
      url: API_URL,
      accounts: [`0x${PRIVATE_KEY}`] // DD NOT UPLOAD WITH PRIVATE KEY better to use env vars
    }
  }
};