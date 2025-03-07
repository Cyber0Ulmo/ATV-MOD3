// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract ERC721Token is ERC721 {
    // State Variables
    uint256 public tokenCount;               
    address public admin;                          
    mapping(address => bool) public minters;       
    mapping(address => bool) public burners;       

    // Custom Errors with descriptive messages
    error ERC721Token_NonExistentNFT(string message);            
    error Unauthorized(string message);                          

    // Events
    event MinterAdded(address indexed account);    
    event MinterRemoved(address indexed account);  
    event BurnerAdded(address indexed account);    
    event BurnerRemoved(address indexed account);

    // Modifiers 
    modifier onlyAdmin() {
        if (msg.sender != admin) revert Unauthorized("Caller is not contract admin");
        _;
    }

    modifier onlyMinter() {
        if (!minters[msg.sender]) revert Unauthorized("Caller is not authorized minter");
        _;
    }

    modifier onlyBurner() {
        if (!burners[msg.sender]) revert Unauthorized("Caller is not authorized burner");
        _;
    }

    constructor() ERC721("The Master Meister", "TMM") {
        admin = msg.sender;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        if (_ownerOf(tokenId) == address(0)) 
            revert ERC721Token_NonExistentNFT("Query for nonexistent token");
        return "https://ipfs.io/ipfs/bafkreife5kuwwsuvdrwzgunkjyuyjo2zghfvcnseiwonpbjru3mn4rle5u";
    }

    function mintNFT(address to) public onlyMinter {
        tokenCount += 1;
        _mint(to, tokenCount);
    }

    function burnNFT(uint256 tokenId) public onlyBurner {
        _burn(tokenId);
    }

    function addMinter(address minter) public onlyAdmin {
        if (minters[minter]) 
            revert Unauthorized("Address already has minter role");
        minters[minter] = true;
        emit MinterAdded(minter);
    }

    function removeMinter(address minter) public onlyAdmin {
        if (!minters[minter]) 
            revert Unauthorized("Address does not have minter role");
        minters[minter] = false;
        emit MinterRemoved(minter);
    }

    function addBurner(address burner) public onlyAdmin {
        if (burners[burner]) 
            revert Unauthorized("Address already has burner role");
        burners[burner] = true;
        emit BurnerAdded(burner);
    }

    function removeBurner(address burner) public onlyAdmin {
        if (!burners[burner]) 
            revert Unauthorized("Address does not have burner role");
        burners[burner] = false;
        emit BurnerRemoved(burner);
    }
}