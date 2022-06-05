# @version 0.2.8
# @title flash_bento.vy
# @notice a simple example using vyper for a flash loan from Sushi's BentoBox
# @author Maka
# --


# @notice bento's flashloan ability.
# @param borrower: address of the contract to be called back.
# @param receiver: address of the token receiver.
# @param token: address of the token to receive.
# @param amount: number of the tokens to receive.
# @param calldata: encoded data to pass to the `borrower` contract.
interface Bento:
  def flashLoan(
    borrower: address, 
    receiver: address, 
    token: address, 
    amount: uint256, 
    data: Bytes[b]
  ): nonpayable

interface IERC20:
  def balanceOf(account: address) -> uint256: view
  def transfer(recipient: address, amount: uint256) -> bool: nonpayable
 
b: constant(uint256) = 32 * 8
admin: address
bento: public(address)
weth: public(address)
# --


# init
@external
def __init__(_bento: address, _weth: address):
  self.admin = msg.sender
  self.bento = _bento
  self.weth = _weth

# easy eth deposit
@external
@payable
def __default__():
  raw_call(
    self.weth, method_id('deposit()'), value = msg.value, max_outsize=0)
# --


# function to be called back
# `amount` + `fee` needs to be repayed to msg.sender before call returns.
# @notice The function bento will callback, giving us access to the following args. 
# @param sender: address of the invoker.
# @param token: address of the token loaned.
# @param amount: quantity of `token` loaned.
# @param fee: amount that needs to be paid for loan. Same as `token`.
# @param data: the calldata we passed to flashloan function.
@external
def onFlashLoan(sender: address, token: address, amount: uint256, fee: uint256, data: Bytes[b]):
  assert msg.sender == self.bento
  total: uint256 = amount + fee
  # do something with the data
  # ...
  # repay
  IERC20(token).transfer(self.bento, total)


# function we call to invoke the loan
@external
def borrow(_token:address, _amount:uint256, _data:Bytes[b]):
  Bento(self.bento).flashLoan(self, self, _token, _amount, _data)
# --


# clean up functions, useful when testing
@external 
def withdraw(_token: address):
  assert msg.sender == self.admin
  IERC20(_token).transfer(self.admin, IERC20(_token).balanceOf(self))

@external
def sweep():
  assert msg.sender == self.admin  
  selfdestruct(self.admin)

# 1love
