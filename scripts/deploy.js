const hre = require("hardhat");

async function main() {
  const DataConsumerV3 = await hre.ethers.deployContract("DataConsumerV3");
  await DataConsumerV3.waitForDeployment();

  console.log(`Deployed to ${DataConsumerV3.target}`);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
