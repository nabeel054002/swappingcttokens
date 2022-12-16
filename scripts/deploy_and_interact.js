const { ethers } = require("hardhat");
require("dotenv").config({ path: ".env" });
const {BigNumber} = require("ethers");

async function main() {
    const swaps = await ethers.getContractFactory("SwapSingle");
    const deployedswaps = await swaps.deploy("0xE592427A0AEce92De3Edee1F18E0157C05861564");
    await deployedswaps.deployed();
    console.log("Address of SwapSingle Contract:", deployedswaps.address);
}

main()
.then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

