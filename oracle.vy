#--
# @version 0.3.3
# @notice Mainnet Chainlink Price Feed - ETH/USD (Scale: 8)
# @title Oracle.vy
# @author Maka
#-

#-- Interface for Price Feed
interface AggregatorV3Interface:
  def latestRoundData() -> (
    uint256,
    int128,
    uint256,
    uint256,
    uint256
  ): view
#-

#-- Address of Feed
PRICE_FEED: constant(address) = 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
#-

#- Function returning price
@external
@view
def get_latest_price () -> int128:
  round_ID: uint256 = 0
  price: int128 = 0 
  started_at: uint256 = 0 
  time_stamp: uint256 = 0
  answered_in_round: uint256 = 0
  (
    round_ID,
    price, 
    started_at, 
    time_stamp,
    answered_in_round
  ) = AggregatorV3Interface(PRICE_FEED).latestRoundData()
  return price
#- 1love
