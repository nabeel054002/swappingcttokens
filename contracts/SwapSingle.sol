// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.6;
pragma abicoder v2;

//import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)external
        returns (bool);

    function approve(address spender, uint256 amount) external returns (bool);
}

contract SwapSingle {
    ISwapRouter public immutable swapRouter;

    address public constant DAI = 0x9c3C9283D3e44854697Cd22D3Faa240Cfb032889;

    address public constant WETH9 = 0xB2E82ecd63861BBc39D7A95211112EB464d5CD25;

    uint24 public constant poolFee = 3000;

    constructor(ISwapRouter _swapRouter) {
        swapRouter = _swapRouter;
    }

    IERC20 public daiToken = IERC20(DAI);
    //dai as in wmatic, some input tokens

    function swapExactInputSingle(uint256 amountIn) external returns (uint256 amountOut) {

        // TransferHelper.safeTransferFrom(DAI, msg.sender, address(this), amountIn);

        // // Approve the router to spend DAI.
        // TransferHelper.safeApprove(DAI, address(swapRouter), amountIn);

        //new code implement

        daiToken.approve(address(swapRouter), amountIn);

        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: DAI,
                tokenOut: WETH9,
                fee: poolFee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        // The call to `exactInputSingle` executes the swap.
        amountOut = swapRouter.exactInputSingle(params);
    }

    // function swapExactOutputSingle(uint256 amountOut, uint256 amountInMaximum) external returns (uint256 amountIn) {
    //     TransferHelper.safeTransferFrom(DAI, msg.sender, address(this), amountInMaximum);

    //     TransferHelper.safeApprove(DAI, address(swapRouter), amountInMaximum);

    //     ISwapRouter.ExactOutputSingleParams memory params =
    //         ISwapRouter.ExactOutputSingleParams({
    //             tokenIn: DAI,
    //             tokenOut: WETH9,
    //             fee: poolFee,
    //             recipient: msg.sender,
    //             deadline: block.timestamp,
    //             amountOut: amountOut,
    //             amountInMaximum: amountInMaximum,
    //             sqrtPriceLimitX96: 0
    //         });

    //     // Executes the swap returning the amountIn needed to spend to receive the desired amountOut.
    //     amountIn = swapRouter.exactOutputSingle(params);

    //     // For exact output swaps, the amountInMaximum may not have all been spent.
    //     // If the actual amount spent (amountIn) is less than the specified maximum amount, we must refund the msg.sender and approve the swapRouter to spend 0.
    //     if (amountIn < amountInMaximum) {
    //         TransferHelper.safeApprove(DAI, address(swapRouter), 0);
    //         TransferHelper.safeTransfer(DAI, msg.sender, amountInMaximum - amountIn);
    //     }
    // }
}


/*
function swapExactInputSingle(uint256 amountIn)
        external
        returns (uint256 amountOut)
    {
        linkToken.approve(address(swapRouter), amountIn);

        ISwapRouter.ExactInputSingleParams memory params = ISwapRouter
            .ExactInputSingleParams({
                tokenIn: LINK,
                tokenOut: WETH,
                fee: poolFee,
                recipient: address(this),
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        amountOut = swapRouter.exactInputSingle(params);
    }
 */


////OLD CONTRACT

// pragma solidity =0.7.6;
// pragma abicoder v2;
// //this is the actual code to be deployed
// import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';
// import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';

// interface IERC20 {
//     function transfer(address recipient, uint256 amount) external returns (bool);
//     function approve(address spender, uint256 amount) external returns (bool);
//     function balanceOf(address account) external view returns (uint256);
//     function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
// }

// contract SwapSingle {

//     ISwapRouter public immutable swapRouter;

//     // For this example, we will set the pool fee to 0.3%.
//     uint24 public constant poolFee = 3000;

//     constructor(ISwapRouter _swapRouter) {
//         swapRouter = _swapRouter;
//     }

//     function swapExactInputSingle (uint256 amountIn, address _tokenOne, address _t) external payable returns (uint256 amountOut) {
//         IERC20 tokenOne = IERC20(_tokenOne);
//         address _tokenTwo = 0xB2E82ecd63861BBc39D7A95211112EB464d5CD25;
//         IERC20 tokenTwo = IERC20(_t);

//         TransferHelper.safeTransferFrom(_tokenOne, msg.sender, address(this), amountIn);

//         // Approve the router to spend DAI.
//         TransferHelper.safeApprove(_tokenOne, address(swapRouter), amountIn);

//         // //so the smart contract is directly considering the case4 that it has the otkens 
//         // //tokenOne.transferFrom(msg.sender, address(this), amountIn);
//         // TransferHelper.safeTransferFrom(tokenOne, msg.sender, address(this), amountIn);

//         // // Approve the router to spend tokenOne.
//         // tokenOne.approve(address(swapRouter), amountIn);
        
//         ISwapRouter.ExactInputSingleParams memory params =
//             ISwapRouter.ExactInputSingleParams({
//                 tokenIn: _tokenOne,
//                 tokenOut: _tokenTwo,
//                 fee: poolFee,
//                 recipient: msg.sender,
//                 deadline: block.timestamp,
//                 amountIn: amountIn,
//                 amountOutMinimum: 0,
//                 sqrtPriceLimitX96: 0
//             });
//         amountOut = swapRouter.exactInputSingle(params);
//     }
// }

//0xBA6b90Ce2b6f95FFF36CA256912dDBbbEdC78097