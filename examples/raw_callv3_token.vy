# @version 0.3.9
# @title raw_callv3_token
# @auther Maka

interface IERC20:
  def approve(spender: address, amount: uint256) -> bool: nonpayable
  def transferFrom(sender: address, recipient: address, amount: uint256) -> bool: nonpayable

USDC: constant(address) = 0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174
UNIV3_ROUTER: constant(address) = 0xE592427A0AEce92De3Edee1F18E0157C05861564

@external
def swap_usdc(amount_in: uint256, outtoken: address, destination: address, fee: uint256):
  IERC20(USDC).transferFrom(msg.sender, self, amount_in)
  IERC20(USDC).approve(UNIV3_ROUTER, amount_in)

  raw_call(
    UNIV3_ROUTER,
    concat(
      method_id("exactInputSingle((address,address,uint24,address,uint256,uint256,uint256,uint160))"),
      convert(USDC, bytes32),
      convert(outtoken, bytes32),
      convert(fee, bytes32),
      convert(destination, bytes32),
      convert(block.timestamp, bytes32),
      convert(amount_in, bytes32),
      convert(0, bytes32),
      convert(0, bytes32)
    )
  )
