// SPDX-License-Identifier: MIT

pragma solidity ^0.7.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import '@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol';
import "@openzeppelin/contracts/token/ERC20/ERC20Burnable.sol";

import "./behaviours/ERC20Mintable.sol";
import "../../access/Roles.sol";
import "../../service/ServicePayer.sol";

/**
 * @title TokenineERC20 
 * @dev Implementation of the TokenineERC20 
 */
contract TokenineERC20  is ERC20Mintable, ERC20Burnable, Ownable, Roles, ERC20Pausable {

    constructor (
        string memory name,
        string memory symbol,
        uint8 decimals
    )
        ERC20(name, symbol)
    {
        _setupDecimals(decimals);
    }

    // required for token to be burnable and pausable both
    function _beforeTokenTransfer(address from, address to, uint256 amount) internal virtual override(ERC20, ERC20Pausable) {
        super._beforeTokenTransfer(from, to, amount);
    }

    function transfer(address recipient, uint256 amount) public virtual override whenNotPaused returns (bool) {
        super.transfer(recipient, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public virtual override whenNotPaused returns (bool) {
        super.transferFrom(sender, recipient, amount);
        return true;
    }

    function stop() public {
        super._pause();
    }

    function start() public {
        super._unpause();
    }

    /**
     * @dev Function to mint tokens.
     *
     * NOTE: restricting access to owner only. See {ERC20Mintable-mint}.
     *
     * @param account The address that will receive the minted tokens
     * @param amount The amount of tokens to mint
     */
    function _mint(address account, uint256 amount) internal override onlyMinter {
        super._mint(account, amount);
    }

    /**
     * @dev Function to stop minting new tokens.
     *
     * NOTE: restricting access to owner only. See {ERC20Mintable-finishMinting}.
     */
    function _finishMinting() internal override onlyOwner {
        super._finishMinting();
    }
}
