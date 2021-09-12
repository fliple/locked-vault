// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RynoLocker is Ownable {
  using SafeMath for uint256;

  ERC20 public token;
  uint256 public start;
  uint256 public duration;
  uint256 public totalSupply;
  uint256 public totalClaimed;

  event Claim(address indexed recipient, uint256 amount);

  constructor(address _token, uint256 _duration, uint256 _totalSupply) {
    token = ERC20(_token);
    start = block.timestamp;
    duration = _duration;
    totalSupply = _totalSupply * 10 ** 18;
    totalClaimed = 0;
  }

  function getClaimableAmount() public view returns(uint256) {
    uint daysPassed = block.timestamp.sub(start).div(1 days);

    if (daysPassed >= duration) {
      return token.balanceOf(address(this));
    } else {
      uint256 amountPerDay = totalSupply.div(duration);
      return amountPerDay.mul(daysPassed).sub(totalClaimed);
    }
  }

  function claim(uint256 amount) external onlyOwner returns(bool) {
    uint256 claimableAmount = getClaimableAmount();
    require(claimableAmount >= amount, 'Vault:: Insufficient amount');
    token.transfer(owner(), amount);
    totalClaimed += amount;

    emit Claim(msg.sender, amount);
    return true;
  }
}