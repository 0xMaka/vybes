# @version 0.3.9
# @title raw_callv3_eth
# @auther Maka
  
  interface IERC20:
  def approve(spender: address, amount: uint256) -> bool: nonpayable
  def transferFrom(sender: address, recipient: address, amount: uint256) -> bool: nonpayable

WETH: constant(address) = 0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270
UNIV3_ROUTER: constant(address) = 0xE592427A0AEce92De3Edee1F18E0157C05861564

@payable
@external
def swap_eth(amount_in: uint256, outtoken: address, destination: address, fee: uint256):
  assert msg.value >= amount_in, 'Not enough eth supplied.'

  raw_call(
    UNIV3_ROUTER,
    concat(
      method_id("exactInputSingle((address,address,uint24,address,uint256,uint256,uint256,uint160))"),
      convert(WETH, bytes32),
      convert(outtoken, bytes32),
      convert(fee, bytes32),
      convert(destination, bytes32),
      convert(block.timestamp, bytes32),
      convert(amount_in, bytes32),
      convert(0, bytes32),
      convert(0, bytes32)
    ),
    value=msg.value  # pass the native to the router
  )
