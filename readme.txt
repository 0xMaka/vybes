# vybes
For fun and study, with some vy (and maybe a lil py).

rescue.vy - ^0.3.3
- testing: new dynamic arrays with vyper 0.3.3; the swap would have previously needed a raw_call (can see interface.vy).
- contract: will recover usdc sent to the SushiV2Router on goerli. 
  removeLiquidityETHSupportingFeeOnTransferTokens, can be used to rescue tokens stuck at an address, hold tight HK for first showing me that one. There are some variations on it, you can get mileage from the concept of burning tokens to free tokens.
- instructions: none

vWETH.vy - ^0.2.16
- testing: what a weth implemented in vyper might look like. Some noteable diffs in the fallback and deposit, as you can't call functions pre declaraion in vyper, nor call an external function internally. Can also note a lack of requires or asserts, since they arent needed, vyper will revert on underflow.
- contract: will launch a standard WETH9 style contract, chain agnostic.
- instructions: none
[+] - look at replacing public variables with constants, instead creating @view functions for those

flashBento.vy - ^0.2.8
- testing: ease with which we can perform a flash loan via bentobox.
- contract: will deploy a simple contract one can use to test the flash loan function of bentobox on any network.
- instructions: constructor takes weth and bento address. Send the contract enough of the token to repay, then call the borrow function.
[+] - will add more flash loan examples on other contracts

interface.vy - ^0.2.16
- testing: different types of external functions calls, interfacing with contracts, includes a work around for handling dynamic arrays pre 0.3.3.
- contract: will launch an "interfacestation" that you can use to view a balance of a token, total supply or exchange two tokens using the router provided.
- instructions: constructor arguments include weth, and router address. Any univ2 style router should work, grab the weth address from the router.

VIM.vy - ^0.2.16
- testing: minimum viable token, used in other testing.
- contract: will deploy a VIM token, sending the total supply to deployer. Contract features just 3 writable functions, approve, transfer and transferFrom.
  chain agnostic
- instructions: none 
[+] - to be replaced with generic example

