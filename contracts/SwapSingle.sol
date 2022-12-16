// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.7.6;
pragma abicoder v2;

import '@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol';
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';


contract SwapSingle {
    ISwapRouter public immutable swapRouter;

    event swapsImplemented(address swapper, uint256 quantity, uint256 timestamp);

    uint24 public constant poolFee = 3000;

    constructor(ISwapRouter _swapRouter) {
        swapRouter = _swapRouter;
    }


    function swapExactInputSingle(uint256 amountIn, address coinIn, address coinOut) payable external returns (uint256 amountOut) {

        TransferHelper.safeTransferFrom(coinIn, msg.sender, address(this), amountIn);

        // Approve the router to spend DAI.
        TransferHelper.safeApprove(coinIn, address(swapRouter), amountIn);

        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: coinIn,
                tokenOut: coinOut,
                fee: poolFee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        // The call to `exactInputSingle` executes the swap.
        amountOut = swapRouter.exactInputSingle(params);

        emit swapsImplemented(msg.sender, amountIn, block.timestamp);
    }
}


