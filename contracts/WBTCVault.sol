// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@aave/core-v3/contracts/interfaces/IPool.sol";

contract WBTCVault {
    IERC20 public wbtcToken;
    IPool public aavePool;

    mapping(address => uint256) public userWBTCBalances;

    constructor(address _wbtcToken, address _aavePool) {
        wbtcToken = IERC20(_wbtcToken);
        aavePool = IPool(_aavePool);
    }

    function depositWBTC(uint256 amount) external {
        require(amount > 0, "Amount must be greater than 0");
        wbtcToken.transferFrom(msg.sender, address(this), amount);
        wbtcToken.approve(address(aavePool), amount);
        aavePool.supply(address(wbtcToken), amount, address(this), 0);
        userWBTCBalances[msg.sender] += amount;
    }

    function withdrawWBTC(uint256 amount) external {
        require(userWBTCBalances[msg.sender] >= amount, "Insufficient balance");
        aavePool.withdraw(address(wbtcToken), amount, msg.sender);
        userWBTCBalances[msg.sender] -= amount;
    }
}
