// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.4;

import {DSTest} from "ds-test/test.sol";
import {Vm} from "forge-std/Vm.sol";
import {console} from "log/console.sol";
import {HeliosBS, Blacksmith, Helios} from "./blacksmith/Helios.bs.sol";
import {XYKswapper} from "../swappers/XYKswapper.sol";
import {ERC20BS} from "./blacksmith/ERC20.bs.sol";
import {MockERC20} from "solmate/test/utils/mocks/MockERC20.sol";
import {IPairSwap} from "../interfaces/IPairSwap.sol";

contract HeliosTest is DSTest {
    Vm internal vm = Vm(HEVM_ADDRESS);
    Helios helios;
    XYKswapper xy;
    MockERC20 token0;
    MockERC20 token1;
    struct User {
        address addr; // to avoid external call, we save it in the struct
        Blacksmith base;
        ERC20BS token0;
        ERC20BS token1;
        HeliosBS helios;
    }
    User alice;

    function createUser(address _addr, uint256 _privateKey)
        public
        returns (User memory)
    {
        Blacksmith base = new Blacksmith(_addr, _privateKey);
        ERC20BS _token0 = new ERC20BS(_addr, _privateKey, address(token0));
        ERC20BS _token1 = new ERC20BS(_addr, _privateKey, address(token1));
        HeliosBS _helios = new HeliosBS(_addr, _privateKey, address(helios));
        base.deal(100 ether);
        return User(base.addr(), base, _token0, _token1, _helios);
    }

    function setUp() public {
        token0 = new MockERC20("TokenA", "A", 18);
        token1 = new MockERC20("TokenB", "B", 18);
        xy = new XYKswapper();
        helios = new Helios();
        alice = createUser(address(0), 111);
        token0.mint(alice.addr, 1000 ether);
        token1.mint(alice.addr, 1000 ether);
    }

    function testCreatePair() public {
        alice.token0.approve(address(helios), 100 ether);
        alice.token1.approve(address(helios), 100 ether);

        (uint256 id, uint256 liq) = alice.helios.createPair(
            alice.addr,
            address(token0),
            address(token1),
            100 ether,
            100 ether,
            xy,
            0,
            "0x"
        );

        (address t0, address t1, , , , ) = helios.pairs(id);
        assertTrue(t0 == address(token0));
        assertTrue(t1 == address(token1));
        assertTrue(helios.balanceOf(alice.addr, id) == liq);
        assertTrue(helios.totalSupplyForId(id) == liq);
        assertTrue(alice.token0.balanceOf(alice.addr) == 900 ether);
        assertTrue(alice.token1.balanceOf(alice.addr) == 900 ether);
    }

    function testFailCreatePairWithIdenticalTokens() public {
        alice.helios.createPair(
            alice.addr,
            address(token0),
            address(token0),
            100 ether,
            100 ether,
            xy,
            0,
            "0x"
        );
    }

    function testFailCreatePairWithoutSwapper() public {
        alice.helios.createPair(
            alice.addr,
            address(token0),
            address(token0),
            100 ether,
            100 ether,
            XYKswapper(address(0)),
            0,
            "0x"
        );
    }
}
