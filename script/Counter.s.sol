// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {Counter} from "../src/Counter.sol";
import {TestExt} from "lib/forge-zksync-std/src/TestExt.sol";

contract CounterScript is Script, TestExt {
    Counter public counter;

    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("WALLET_PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // Encode paymaster input
        bytes memory paymaster_encoded_input =
            abi.encodeWithSelector(bytes4(keccak256("general(bytes)")), bytes("0x"));
        vmExt.zkUsePaymaster(vm.envAddress("PAYMASTER_ADDRESS"), paymaster_encoded_input);
        counter = new Counter();

        vm.stopBroadcast();
    }
}
