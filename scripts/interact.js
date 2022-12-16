const {ethers, BigNumber, Contract, utils} = require("ethers");
require('dotenv').config("../.env")
const MUMBAI_PROVIDER=new ethers.providers.JsonRpcProvider(process.env.QUICKNODE_HTTP_URL);
const WALLET_ADDRESS = process.env.WALLET_ADDRESS;
const WALLET_PRIVATE_KEY=process.env.PRIVATE_KEY;
const {tokenabi, abi} = require("../constants/index");

const wallet = new ethers.Wallet(WALLET_PRIVATE_KEY);
const connectedWallet = wallet.connect(MUMBAI_PROVIDER);
const swapsAddress = "0x329b1b7227162525a2e4E7E62d1Adba321DE3055";
const WMATIC_ADDRESS="0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889";
const CT_ADDRESS="0xB2E82ecd63861BBc39D7A95211112EB464d5CD25";

async function main(){
    const swapsContract = new ethers.Contract(swapsAddress, abi, MUMBAI_PROVIDER);
    const ctContract = new Contract(CT_ADDRESS, tokenabi, MUMBAI_PROVIDER);

    const wmaticContract = new Contract(WMATIC_ADDRESS, tokenabi, MUMBAI_PROVIDER);

    const approvalResponse = await wmaticContract.connect(connectedWallet).approve(swapsAddress,"4100000000000000");
    await approvalResponse.wait();
    let tx = swapsContract.connect(connectedWallet)
    
    tx = await tx.swapExactInputSingle(
        BigInt(4e14),
        WMATIC_ADDRESS,
        CT_ADDRESS
    )
    await tx.wait();
    //how to show the events 
}
main();