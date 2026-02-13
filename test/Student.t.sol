// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {StudentAttendance} from "../src/StudentAttend.sol";

contract StudentAttendanceTest is Test {
    StudentAttendance public attendance;

    function setUp() public {
        attendance = new StudentAttendance();
    }

    function test_alice_joins_the_class() public {
        attendance.welcome_to_class("Alice", 20);
        assertEq(attendance.check_class_size(), 1);
        
        (string memory name, uint8 age, bool present) = attendance.get_student_info(0);
        assertEq(name, "Alice");
        assertEq(age, 20);
        assertEq(present, false);
    }

    function test_bob_marks_himself_present() public {
        attendance.welcome_to_class("Bob", 21);
        attendance.take_attendance(0, true);
        
        (,, bool present) = attendance.get_student_info(0);
        assertTrue(present);
    }

    function test_three_new_students_register() public {
        attendance.welcome_to_class("Charlie", 19);
        attendance.welcome_to_class("Diana", 22);
        attendance.welcome_to_class("Eve", 20);
        
        assertEq(attendance.check_class_size(), 3);
    }

    function test_frank_and_grace_have_different_attendance() public {
        attendance.welcome_to_class("Frank", 18);
        attendance.welcome_to_class("Grace", 23);
        
        attendance.take_attendance(0, true);
        attendance.take_attendance(1, false);
        
        (,, bool present1) = attendance.get_student_info(0);
        (,, bool present2) = attendance.get_student_info(1);
        
        assertTrue(present1);
        assertFalse(present2);
    }

    function test_cannot_find_student_that_doesnt_exist() public {
        vm.expectRevert("Student does not exist");
        attendance.get_student_info(0);
    }

    function test_marking_attendance_for_ghost_student_fails() public {
        vm.expectRevert("Student does not exist");
        attendance.take_attendance(0, true);
    }
}