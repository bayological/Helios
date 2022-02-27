// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./Blacksmith.sol";
import "../../Helios.sol";

contract HeliosBS {
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

    function DOMAIN_SEPARATOR() public prank returns (bytes32) {
        return Helios(target).DOMAIN_SEPARATOR();
    }

	function addLiquidity(address to, uint256 id, uint256 token0amount, uint256 token1amount, bytes memory data) public payable prank returns (uint256) {
        return Helios(target).addLiquidity{value: msg.value}(to, id, token0amount, token1amount, data);
    }

	function balanceOf(address arg0, uint256 arg1) public prank returns (uint256) {
        return Helios(target).balanceOf(arg0, arg1);
    }

	function balanceOfBatch(address[] memory owners, uint256[] memory ids) public prank returns (uint256[] memory) {
        return Helios(target).balanceOfBatch(owners, ids);
    }

	function baseURI() public prank returns (string memory) {
        return Helios(target).baseURI();
    }

	function createPair(address to, address tokenA, address tokenB, uint112 tokenAamount, uint112 tokenBamount, IPairSwap swapper, uint8 fee, bytes memory data) public payable prank returns (uint256, uint256) {
        return Helios(target).createPair{value: msg.value}(to, tokenA, tokenB, tokenAamount, tokenBamount, swapper, fee, data);
    }

	function isApprovedForAll(address arg0, address arg1) public prank returns (bool) {
        return Helios(target).isApprovedForAll(arg0, arg1);
    }

	function multicall(bytes[] memory data) public prank returns (bytes[] memory) {
        return Helios(target).multicall(data);
    }

	function name() public prank returns (string memory) {
        return Helios(target).name();
    }

	function nonces(address arg0) public prank returns (uint256) {
        return Helios(target).nonces(arg0);
    }

	function pairs(uint256 arg0) public prank returns (address, address, IPairSwap, uint112, uint112, uint8) {
        return Helios(target).pairs(arg0);
    }

	function permit(address owner, address operator, bool approved, uint256 deadline, uint8 v, bytes32 r, bytes32 s) public prank  {
        Helios(target).permit(owner, operator, approved, deadline, v, r, s);
    }

	function removeLiquidity(address to, uint256 id, uint256 liq) public payable prank returns (uint256, uint256) {
        return Helios(target).removeLiquidity{value: msg.value}(to, id, liq);
    }

	function safeBatchTransferFrom(address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public prank  {
        Helios(target).safeBatchTransferFrom(from, to, ids, amounts, data);
    }

	function safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes memory data) public prank  {
        Helios(target).safeTransferFrom(from, to, id, amount, data);
    }

	function setApprovalForAll(address operator, bool approved) public prank  {
        Helios(target).setApprovalForAll(operator, approved);
    }

	function supportsInterface(bytes4 interfaceId) public prank returns (bool) {
        return Helios(target).supportsInterface(interfaceId);
    }

	function swap(address to, uint256 id, address tokenIn, uint256 amountIn) public payable prank returns (uint256) {
        return Helios(target).swap{value: msg.value}(to, id, tokenIn, amountIn);
    }

	function symbol() public prank returns (string memory) {
        return Helios(target).symbol();
    }

	function totalSupply() public prank returns (uint256) {
        return Helios(target).totalSupply();
    }

	function uri(uint256 arg0) public prank returns (string memory) {
        return Helios(target).uri(arg0);
    }

}
