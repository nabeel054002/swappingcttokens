// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity =0.7.6;
pragma abicoder v2;
//this is the actual code to be deployed
import '@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol';

interface IERC20 {
    function transfer(address recipient, uint256 amount) external returns (bool);
    function approve(address spender, uint256 amount) external returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
}

contract SwapSingle {

    ISwapRouter public immutable swapRouter;

    // For this example, we will set the pool fee to 0.3%.
    uint24 public constant poolFee = 3000;

    constructor(ISwapRouter _swapRouter) {
        swapRouter = _swapRouter;
    }

    function swapExactInputSingle (uint256 amountIn, address _tokenOne, address _tokenTwo) external payable returns (uint256 amountOut) {
        IERC20 tokenOne = IERC20(_tokenOne);
        IERC20 tokenTwo = IERC20(_tokenTwo);
        //so the smart contract is directly considering the case4 that it has the otkens 
        tokenOne.transferFrom(msg.sender, address(this), amountIn);
        //TransferHelper.safeTransferFrom(tokenOne, msg.sender, address(this), amountIn);

        // Approve the router to spend tokenOne.
        tokenOne.approve(address(swapRouter), amountIn);
        
        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: _tokenOne,
                tokenOut: _tokenTwo,
                fee: poolFee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });
        amountOut = swapRouter.exactInputSingle(params);
    }
}