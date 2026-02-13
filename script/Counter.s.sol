// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {StudentAttendance} from "../src/StudentAttend.sol";

contract CounterScript is Script {
    StudentAttendance public Student;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        Student = new StudentAttendance();

        vm.stopBroadcast();
    }
}
