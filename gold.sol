pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Gold is ERC20, Ownable {

    mapping(address => bool) public frozenAccount;

    event FrozenFunds(address target, bool frozen);

    constructor() ERC20("Ninja Gold", "NJG") {
    }

    function freezeAccount(address target, bool freeze) onlyOwner public {
        frozenAccount[target] = freeze;
        emit FrozenFunds(target, freeze);
    }

    function mint(address _to, uint256 _amount) external onlyOwner {
        _mint(_to, _amount);
    }

    function burn(uint256 _amount) external {
        _burn(msg.sender, _amount);
    }

    function _beforeTokenTransfer(
        address from,
        address,
        uint256
    ) internal override virtual {
        require(frozenAccount[from] == false, "FA");
    }
}
