#--                                                                                                                     
# @version 0.2.8                                                                                                        
# @notice A vy implimentation of a vault                                                                                
#  from solidity by example. - not for production

# @title kinko (vault)                                                                                                  
# @author Maka                                                                                                          
#-                                                                                                                      
                                                                                                                        
#--                                                                                                                     
# interface for moving the vault token, and referencing balances                                                        
interface IERC20:                                                                                                       
  def balanceOf(account: address) -> uint256: view                                                                      
  def transfer(recipient: address, amount: uint256) -> bool: nonpayable                                                 
  def transferFrom(sender: address, recipient: address, amount: uint256) -> bool: nonpayable                            
                                                                                                                        
# address of vault token, could hardcode it.                                                                             
token: public(address)                                                                                                  
# mapping of account balances                                                                                           
balanceOf: public((HashMap[address, uint256]))                                                                          
# quantity of current shares                                                                                            
totalSupply: public(uint256)                                                                                            
#-                                                                                                                      
                                                                                                                        
#-- events                                                                                                              
event Deposit:                                                                                                          
  depositer: indexed(address)                                                                                             
  amount_in: uint256                                                                                                    
  shares_minted: uint256                                                                                                
                                                                                                                        
event Withdraw:                                                                                                         
  withdrawer: indexed(address)                                                                                             
  shares_burned: uint256                                                                                                
  amount_out: uint256                                                                                                   
#-                                                                                                                      
                                                                                                                        
#-- constructor                                                                                                         
# set vault token on deployment                                                                                         
@external                                                                                                               
def __init__(_token: address):                                                                                          
  self.token = _token                                                                                                   
#-                                                                                                                      
                                                                                                                        
#-- internal functions                                                                                                  
@internal                                                                                                               
def _mint(_to: address, _shares: uint256):                                                                              
  self.totalSupply += _shares                                                                                           
  self.balanceOf[_to] += _shares                                                                                        
                                                                                                                        
@internal                                                                                                               
def _burn(_from: address, _shares: uint256):                                                                            
  self.totalSupply -= _shares                                                                                           
  self.balanceOf[_from] -= _shares                                                                                      
#--                                                                                                                     
                                                                                                                        
#-- external functions                                                                                                  
@external                                                                                                               
def deposit(_amount: uint256):                                                                                          
#  a= amount                                                                                                            
#  B = balance of token before deposit                                                                                  
#  T = total supply                                                                                                     
#  s = shares to mint                                                                                                   
#                                                                                                                       
#    (T + s) / T = (a + B) / B                                                                                          
#    s = aT / B                                                                                                         
  shares: uint256 = 0                                                                                                   
  if (self.totalSupply == 0):                                                                                           
    shares = _amount                                                                                                    
  else:                                                                                                                 
    shares = (_amount * self.totalSupply) / IERC20(self.token).balanceOf(self)                                          
                                                                                                                        
  self._mint(msg.sender, shares)                                                                                        
  IERC20(self.token).transferFrom(msg.sender, self, _amount)                                                            
  log Deposit(msg.sender, _amount, shares)                                                                              
#-                                                                                                                      
                                                                                                                        
#--                                                                                                                     
@external                                                                                                               
def withdraw(_shares: uint256):                                                                                         
#  a= amount                                                                                                            
#  B = balance of token before withdraw                                                                                 
#  T = total supply                                                                                                     
#  s = shares to burn                                                                                                   
#                                                                                                                       
#    (T - s) / T = (B - a) / B                                                                                          
#    a = sB / T                                                                                                         
#-                                                                                                                      
  amount: uint256 = (_shares * IERC20(self.token).balanceOf(self)) / self.totalSupply                                   
                                                                                                                        
  self._burn(msg.sender, _shares)                                                                                       
  IERC20(self.token).transfer(msg.sender, amount)                                                                       
  log Withdraw(msg.sender, _shares, amount)                                                                                                                                                                                                     
#-                                                                                                                    
                                                                                                                        
#- 1love                                                                                                                
