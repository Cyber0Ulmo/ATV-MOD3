// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol"; // Import adicionado
import {ERC721Token} from "../src/ERC721Token.sol";
import {TokenERC20} from "../src/TokenERC20.sol";
import {TokenERC20PURE} from "../src/TokenERC20PURE.sol";

contract DeployAll is Script {
    function run() external {
        vm.startBroadcast();
        
        // Deploy e log dos endereços
        ERC721Token nftContract = new ERC721Token();
        console.log("ERC721 deployed at:", address(nftContract));
        
        TokenERC20 erc20WithRoles = new TokenERC20(1_000_000 * 10 ** 18);
        console.log("ERC20 com Roles deployed at:", address(erc20WithRoles));
        
        TokenERC20PURE erc20Pure = new TokenERC20PURE(1_000_000 * 10 ** 18);
        console.log("ERC20 PURE deployed at:", address(erc20Pure));
        
        vm.stopBroadcast();
    }
}