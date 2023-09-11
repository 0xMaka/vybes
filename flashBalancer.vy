# @title flashBalancer.vy
# @notice a simple example using vyper for a flash loan from Balancers vault
# @author Maka
# --

VAULT: constant(address) = 0xBA12222222228d8Ba445958a75a0704d566BF2C8

B: constant(uint256) = 2048
admin: address
weth: public(address)
# --

interface IERC20:
  def balanceOf(account: address) -> uint256: view
  def transfer(recipient: address, amount: uint256) -> bool: nonpayable

interface Balancer:
  def flashLoan(
    receiver: address,
    tokens: DynArray[address, 4],
    amounts: DynArray[uint256, 4],
    data: Bytes[B]
  ): nonpayable

@external
def __init__(_weth: address):
  self.admin = msg.sender
  self.weth = _weth

@external
@payable
def __default__():
  raw_call(
    self.weth, method_id('deposit()'), value=msg.value, max_outsize=0)
# --

@external
def makeFlashLoan(
  tokens: DynArray[address, 4],
  amounts: DynArray[uint256, 4],
  userData: Bytes[B]
):
  Balancer(VAULT).flashLoan(self, tokens, amounts, userData)

@external
def receiveFlashLoan(
  tokens: DynArray[address, 4],
  amounts: DynArray[uint256, 4],
  feeAmounts: DynArray[uint256, 4],
  userData: Bytes[B]
):
  assert(msg.sender == VAULT)
  #...
  i: uint256 = 0
  for token in tokens:
    IERC20(token).transfer(VAULT, amounts[i])
    i += 1
