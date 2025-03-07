// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TokenERC20PURE is ERC20 {

    // Mappings for roles
    mapping(address => bool) public minters;
    mapping(address => bool) public burners;
    
    // Address admin
    address public admin;

    // Events to register roles
    event MinterAdded(address indexed account);
    event MinterRemoved(address indexed account);
    event BurnerAdded(address indexed account);
    event BurnerRemoved(address indexed account);
    event AdminChanged(address indexed newAdmin);

    // Modifiers for roles
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only ADMIN can call this function");
        _;
    }

    modifier onlyMinter() {
        require(minters[msg.sender], "Only MINTER can call this function");
        _;
    }

    modifier onlyBurner() {
        require(burners[msg.sender], "Only BURNER can call this function");
        _;
    }
    
    // Constructor
    constructor(uint256 _initialSupply) ERC20("ATVTokenPure", "TkP") {
        _mint(msg.sender, _initialSupply);
        admin = msg.sender;
    }

    // Mint function
    function mint(address to, uint256 amount) public onlyMinter {
        _mint(to, amount);
    }

    // Burn function
    function burn(address from, uint256 amount) public onlyBurner {
        _burn(from, amount);
    }

    // Function to add a minter
    function addMinter(address minter) public onlyAdmin {
        if (minters[minter]) {
            revert("Address is already a minter");
        }
        minters[minter] = true;
        emit MinterAdded(minter);
    }

    // Function to remove a minter
    function removeMinter(address minter) public onlyAdmin {
        if (!minters[minter]) {
            revert("Address is not a minter");
        }
        minters[minter] = false;
        emit MinterRemoved(minter);
    }

    // Function to add a burner
    function addBurner(address burner) public onlyAdmin {
        if (burners[burner]) {
            revert("Address is already a burner");
        }
        burners[burner] = true;
        emit BurnerAdded(burner);
    }

    // Function to remove a burner
    function removeBurner(address burner) public onlyAdmin {
        if (!burners[burner]) {
            revert("Address is not a burner");
        }
        burners[burner] = false;
        emit BurnerRemoved(burner);
    }
}