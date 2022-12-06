//0xE592427A0AEce92De3Edee1F18E0157C05861564
const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });
const {BigNumber} = require("ethers");

async function main() {
    const swaps = await ethers.getContractFactory("SwapSingle");
    const deployedswaps = await swaps.deploy("0xE592427A0AEce92De3Edee1F18E0157C05861564");
    //the time that is to be actually implemented in the second arg is 1 day = 60*60*24, for now, i am keeping it as 2 minutes, hence it will be like 14 minutes before a proposal is acted upone
    await deployedswaps.deployed();
    console.log("Address of SwapSingle Contract:", deployedswaps.address);
    deployedswaps.connect()
}
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });