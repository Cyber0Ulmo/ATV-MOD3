// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { AccessControl } from "@openzeppelin/contracts/access/AccessControl.sol";

contract TokenERC20 is ERC20, AccessControl {
    // define roles
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    // initialize and using roles
	constructor(uint256 _initialSupply) ERC20("ATVToken", "ATvTk") {
        _mint(msg.sender, _initialSupply);
        _grantRole(ADMIN_ROLE, msg.sender);
        _setRoleAdmin(MINTER_ROLE, ADMIN_ROLE);
        _setRoleAdmin(BURNER_ROLE, ADMIN_ROLE);
	}

    // mint function
    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount);
    }

    // burn function
    function burn(address from, uint256 amount) public onlyRole(BURNER_ROLE) {
        _burn(from, amount);
    }

    // function addMinter
    function addMinter(address minter) public onlyRole(ADMIN_ROLE) {
        grantRole(MINTER_ROLE, minter);
    }

    //function removeMinter
    function removeMinter(address minter) public onlyRole(ADMIN_ROLE) {
        revokeRole(MINTER_ROLE, minter);
    }

    // function addBurner
    function addBurner(address burner) public onlyRole(ADMIN_ROLE) {
        grantRole(BURNER_ROLE, burner);
    }

    //function removeBurner
    function removeBurner(address burner) public onlyRole(ADMIN_ROLE) {
        revokeRole(BURNER_ROLE, burner);
    }


}
