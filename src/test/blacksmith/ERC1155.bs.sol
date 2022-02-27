// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;
import "./Blacksmith.sol";
import "../../ERC1155.sol";

contract ERC1155BS {
    Bsvm constant bsvm = Bsvm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    address addr;
    uint256 privateKey;
    address payable target;

    constructor(
        address _addr,
        uint256 _privateKey,
        address _target
    ) {
        addr = _privateKey == 0 ? _addr : bsvm.addr(_privateKey);
        privateKey = _privateKey;
        target = payable(_target);
    }

    modifier prank() {
        bsvm.startPrank(addr, addr);
        _;
    }

    function DOMAIN_SEPARATOR() public prank returns (bytes32) {
        return ERC1155(target).DOMAIN_SEPARATOR();
    }

    function balanceOf(address arg0, uint256 arg1)
        public
        prank
        returns (uint256)
    {
        return ERC1155(target).balanceOf(arg0, arg1);
    }

    function balanceOfBatch(address[] memory owners, uint256[] memory ids)
        public
        prank
        returns (uint256[] memory)
    {
        return ERC1155(target).balanceOfBatch(owners, ids);
    }

    function baseURI() public prank returns (string memory) {
        return ERC1155(target).baseURI();
    }

    function isApprovedForAll(address arg0, address arg1)
        public
        prank
        returns (bool)
    {
        return ERC1155(target).isApprovedForAll(arg0, arg1);
    }

    function name() public prank returns (string memory) {
        return ERC1155(target).name();
    }

    function nonces(address arg0) public prank returns (uint256) {
        return ERC1155(target).nonces(arg0);
    }

    function permit(
        address owner,
        address operator,
        bool approved,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public prank {
        ERC1155(target).permit(owner, operator, approved, deadline, v, r, s);
    }

    function safeBatchTransferFrom(
        address from,
        address to,
        uint256[] memory ids,
        uint256[] memory amounts,
        bytes memory data
    ) public prank {
        ERC1155(target).safeBatchTransferFrom(from, to, ids, amounts, data);
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public prank {
        ERC1155(target).safeTransferFrom(from, to, id, amount, data);
    }

    function setApprovalForAll(address operator, bool approved) public prank {
        ERC1155(target).setApprovalForAll(operator, approved);
    }

    function supportsInterface(bytes4 interfaceId) public prank returns (bool) {
        return ERC1155(target).supportsInterface(interfaceId);
    }

    function symbol() public prank returns (string memory) {
        return ERC1155(target).symbol();
    }

    function uri(uint256 arg0) public prank returns (string memory) {
        return ERC1155(target).uri(arg0);
    }
}
