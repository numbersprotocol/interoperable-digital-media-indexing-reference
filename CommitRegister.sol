// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

contract CommitRegister is Initializable {
    using ECDSA for bytes32;

    mapping(string => uint[]) public commitLogs;

    event Commit(address indexed recorder, string indexed assetCid, string commitData);

    function initialize() public initializer {}

    function commit(string memory assetCid, string memory commitData) public returns (uint256 blockNumber) {
        emit Commit(msg.sender, assetCid, commitData);
        commitLogs[assetCid].push(block.number);
        return block.number;
    }

    function getCommits(string memory assetCid) public view returns (uint[] memory) {
        return commitLogs[assetCid];
    }
}