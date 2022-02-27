// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import {DSTest} from "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import {HeliosBS, Blacksmith, Helios} from "./blacksmith/Helios.bs.sol";
import {XYKswapper} from "../swappers/XYKswapper.sol";
import {ERC20BS} from "./blacksmith/ERC20.bs.sol";
import {ERC20} from "../mocks/ERC20.sol";

contract HeliosTest is DSTest {
    Vm internal vm = Vm(HEVM_ADDRESS);
    Helios hl;
    XYKswapper xy;
    ERC20 tokenA;
    ERC20 tokenB;
    struct User {
        address addr; // to avoid external call, we save it in the struct
        Blacksmith base;
        ERC20BS tokenA;
        ERC20BS tokenB;
    }
    User alice;

    function createUser(address _addr, uint256 _privateKey)
        public
        returns (User memory)
    {
        Blacksmith base = new Blacksmith(_addr, _privateKey);
        ERC20BS _tokenA = new ERC20BS(_addr, _privateKey, address(tokenA));
        ERC20BS _tokenB = new ERC20BS(_addr, _privateKey, address(tokenB));
        base.deal(100 ether);
        return User(base.addr(), base, _tokenA, _tokenB);
    }

    function setUp() public {
        alice = createUser(address(0), 111);
        tokenA = new ERC20("TokenA", "A", alice.addr, 1 ether);
        tokenB = new ERC20("TokenB", "B", alice.addr, 1 ether);
        xy = new XYKswapper();
        hl = new Helios();
    }

    function testExample() public {
        assertTrue(true);
    }
}
