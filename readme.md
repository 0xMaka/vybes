# Vybes

*For fun and study, with some vy (and maybe a lil py).*

## :helicopter: rescue.vy - ^0.3.3
**Testing**: 
- *New dynamic arrays with vyper 0.3.3; the swap would have previously needed a rawcall (can see interface.vy).*

**Contract**: 
- Will recover usdc sent to the SushiV2Router on goerli.  
- - removeLiquidityETHSupportingFeeOnTransferTokens, can be used to rescue tokens stuck at an address, hold tight HK for first showing me that one. 
- - There are some variations on it, you can get mileage from the concept of burning tokens to free tokens.
- instructions: none

## :large_blue_diamond: vWETH.vy - ^0.2.16
**Testing:**
- *What a weth implemented in vyper might look like.* 
- - *Some noteable diffs in the fallback and deposit, as you can't call functions pre declaration in vyper, nor call an external function internally.* 
- - *Can also note a lack of requires or asserts, since they arent needed, vyper will revert on underflow.*

**Contract:** 
- Will launch a standard WETH9 style contract, chain agnostic.
- - Features support for infinate approval
- - Have gone for constants in some cases to save on gas
- Instructions: none

## :bento: flashBento.vy - ^0.2.8
**Testing:** 
- *Ease with which we can perform a flash loan via bentobox.*

**Contract:**
- Will deploy a simple contract one can use to test the flash loan function of bentobox on any network where bento is deployed.
- Instructions: constructor takes weth and bento address. Send the contract enough of the token to repay, then call the borrow function.

:memo: *Will add more flash loan examples on other contracts*

## :bank: vault.vy - ^0.2.8

**Testing:**
- *What a vy implementation of the vault from solidity--by-example might look like*
 
 **Contract:**
 - Will deploy a simple vault implimentation that will mint and burn shares, paying out an amount proportional to any profit or loss in that period.  
 - Instructions: constructor takes address of the 'farm' token.
 
## :crystal_ball: oracle.vy - ^0.3.3

**Testing:**
- *vy implementation of a chain link price oracle*
 
 **Contract:**
 - Will deploy a simple oracle contract that can pull price from a feed.  
 - Instructions: Tested on ethereum, set feed address if deploying elsewhere.
   
## :satellite:  interface.vy - ^0.2.16
  **Testing:**
  - *A variety of external functions calls, interfacing with contracts, includes a work around for handling dynamic arrays pre 0.3.3*

  **Contract:** 
  - Will launch an "interfacestation" that you can use to view a balance of a token, total supply or exchange two tokens using the router provided.
  - instructions: constructor arguments include weth, and router address. Any univ2 style router should work, grab the weth address from the router.

## :ticket: NAS.vy - ^0.2.8
**Testing:** 
- *Minimum viable token, used in other testing.*

**Contract:** 
- Will deploy a simple token, sending the total supply to deployer. Contract features just 3 writable functions, approve, transfer and transferFrom.
  chain agnostic.
- Instructions: constructor takes 4 parameters, name (string), symbol(string), decimals(uint256), and supply(uint256)
