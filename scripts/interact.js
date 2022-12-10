const {ethers, BigNumber, Contract, utils} = require("ethers");
require('dotenv').config()
const MUMBAI_PROVIDER=new ethers.providers.JsonRpcProvider(process.env.QUICKNODE_HTTP_URL);
const WALLET_ADDRESS = process.env.WALLET_ADDRESS;
const WALLET_PRIVATE_KEY=process.env.PRIVATE_KEY;
const {tokenabi, abi} = require("../constants/index.js");

const wallet = new ethers.Wallet(WALLET_PRIVATE_KEY);
const connectedWallet = wallet.connect(MUMBAI_PROVIDER);

const swapsAddress = "0x65ec79614f6487461CBc2c30941EA783E50e0373";
const MATIC_ADDRESS="0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889";
const CT_ADDRESS="0xB2E82ecd63861BBc39D7A95211112EB464d5CD25";

async function main(){
    const swapsContract = new ethers.Contract(swapsAddress, abi, MUMBAI_PROVIDER);
    const ctContract = new Contract(CT_ADDRESS, tokenabi, MUMBAI_PROVIDER);
    //let tx = await ctContract.connect(connectedWallet).approve(swapsAddress, "11000000000000000000000");
    //await tx.wait();
    const wmaticContract = new Contract(MATIC_ADDRESS, tokenabi, MUMBAI_PROVIDER);

    const approvalResponse = await wmaticContract.connect(connectedWallet).approve(swapsAddress,"4100000000000000");
    await approvalResponse.wait();
    const tx = await swapsContract.connect(connectedWallet).swapExactInputSingle(
        BigInt(4e14),
        //above number is how much u will input
        // MATIC_ADDRESS,
        // CT_ADDRESS,
        {
            gasLimit:BigInt(1e5),
        }
        //add more matic
    )
    await tx.wait();
    //console.log("Transaction is like", tx);
    //i am continously getting estimategaserrors in the transactions only, well ig 
    //uits because4 they happen in that only or i could add a higher gas limit

}
main();