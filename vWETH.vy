# @version ^0.3.3
# 
# @notice WETH implementation in vy
# @author Maka
# @title vWETH9

NAME: constant(String[14])    = 'Wrapped Ether'
SYMBOL: constant(String[4])   = 'WETH'
DECIMALS: constant(uint256)   = 18

event Approval:
  src: indexed(address) 
  guy: indexed(address) 
  wad: uint256

event Transfer:
  src: indexed(address)
  dst: indexed(address)
  wad: uint256 

event Deposit:
  dst: indexed(address) 
  wad: uint256

event Withdrawal:
  src: indexed(address) 
  wad: uint256

balanceOf: public(HashMap[address, uint256])
allowance: public(HashMap[address, HashMap[address, uint256]])

@internal
def _deposit(src: address, val: uint256):
  self.balanceOf[src] += val
  log Deposit(src, val)

@external
@payable
def __default__(): 
  self._deposit(msg.sender, msg.value)

@external
@payable
def deposit():
  self._deposit(msg.sender, msg.value)

@external
def withdraw(wad: uint256):
  self.balanceOf[msg.sender] -= wad
  send(msg.sender, wad)
  log Withdrawal(msg.sender, wad)

@external
@view
def totalSupply() -> uint256:
  return self.balance

@external
@view
def name() -> String[14]:
  return NAME

@external
@view
def symbol() -> String[4]:
  return SYMBOL


@external
@view
def decimals() -> uint256:
  return DECIMALS


@external
def approve(guy: address, wad: uint256) -> bool:
  self.allowance[msg.sender][guy] = wad
  log Approval(msg.sender, guy, wad)
  return True

@external
def transfer(dst: address, wad: uint256) -> bool:
  self.balanceOf[msg.sender] -= wad
  self.balanceOf[dst] += wad
  log Transfer(msg.sender, dst, wad)
  return True

@external
def transferFrom(src: address, dst: address, wad: uint256) -> bool:
  allowance: uint256 = self.allowance[src][msg.sender]
  if (src != msg.sender and allowance < MAX_UINT256):
    self.allowance[src][msg.sender] = allowance - wad
  self.balanceOf[src] -= wad
  self.balanceOf[dst] += wad
  log Transfer(src, dst, wad)
  return True 

# 1love
