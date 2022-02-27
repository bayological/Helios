// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import {DSTest} from "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import {console} from "log/console.sol";
import {HeliosBS, Blacksmith, Helios} from "./blacksmith/Helios.bs.sol";
import {XYKswapper} from "../swappers/XYKswapper.sol";
import {ERC20BS} from "./blacksmith/ERC20.bs.sol";
import {MockERC20} from "solmate/test/utils/mocks/MockERC20.sol";

contract HeliosTest is DSTest {
    Vm internal vm = Vm(HEVM_ADDRESS);
    Helios helios;
    XYKswapper xy;
    MockERC20 tokenA;
    MockERC20 tokenB;
    struct User {
        address addr; // to avoid external call, we save it in the struct
        Blacksmith base;
        ERC20BS tokenA;
        ERC20BS tokenB;
        HeliosBS helios;
    }
    User alice;

    function createUser(address _addr, uint256 _privateKey)
        public
        returns (User memory)
    {
        Blacksmith base = new Blacksmith(_addr, _privateKey);
        ERC20BS _tokenA = new ERC20BS(_addr, _privateKey, address(tokenA));
        ERC20BS _tokenB = new ERC20BS(_addr, _privateKey, address(tokenB));
        HeliosBS _helios = new HeliosBS(_addr, _privateKey, address(helios));
        base.deal(100 ether);
        return User(base.addr(), base, _tokenA, _tokenB, _helios);
    }

    function setUp() public {
        tokenA = new MockERC20("TokenA", "A", 18);
        tokenB = new MockERC20("TokenB", "B", 18);
        xy = new XYKswapper();
        helios = new Helios();
        alice = createUser(address(0), 111);
        tokenA.mint(alice.addr, 1000 ether);
        tokenB.mint(alice.addr, 1000 ether);
    }

    function testCreatePair() public {
        alice.tokenA.approve(address(helios), 100 ether);
        alice.tokenB.approve(address(helios), 100 ether);
        alice.helios.createPair(
            alice.addr,
            address(tokenA),
            address(tokenB),
            100 ether,
            100 ether,
            xy,
            0,
            "0x"
        );
    }
}
