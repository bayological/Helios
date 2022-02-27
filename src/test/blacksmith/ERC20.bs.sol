// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./Blacksmith.sol";
import "../../mocks/ERC20.sol";

contract ERC20BS {
    Bsvm constant bsvm = Bsvm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    address addr;
    uint256 privateKey;
    address payable target;
    
    constructor( address _addr, uint256 _privateKey, address _target) {
        addr = _privateKey == 0 ? _addr : bsvm.addr(_privateKey);
        privateKey = _privateKey;
        target = payable(_target);
    }

    modifier prank() {
        bsvm.startPrank(addr, addr);
        _;
    }

    function allowance(address arg0, address arg1) public prank returns (uint256) {
        return ERC20(target).allowance(arg0, arg1);
    }

	function approve(address to, uint256 amount) public prank returns (bool) {
        return ERC20(target).approve(to, amount);
    }

	function balanceOf(address arg0) public prank returns (uint256) {
        return ERC20(target).balanceOf(arg0);
    }

	function decimals() public prank returns (uint8) {
        return ERC20(target).decimals();
    }

	function name() public prank returns (string memory) {
        return ERC20(target).name();
    }

	function symbol() public prank returns (string memory) {
        return ERC20(target).symbol();
    }

	function totalSupply() public prank returns (uint256) {
        return ERC20(target).totalSupply();
    }

	function transfer(address to, uint256 amount) public prank returns (bool) {
        return ERC20(target).transfer(to, amount);
    }

	function transferFrom(address from, address to, uint256 amount) public prank returns (bool) {
        return ERC20(target).transferFrom(from, to, amount);
    }

}
