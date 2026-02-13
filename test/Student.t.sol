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
        attendance.addStudent("Alice", 20);
        assertEq(attendance.getTotalStudents(), 1);
        
        (string memory name, uint8 age, bool present) = attendance.getStudent(0);
        assertEq(name, "Alice");
        assertEq(age, 20);
        assertEq(present, false);
    }

    function test_bob_marks_himself_present() public {
        attendance.addStudent("Bob", 21);
        attendance.updateAttendance(0, true);
        
        (,, bool present) = attendance.getStudent(0);
        assertTrue(present);
    }

    function test_three_new_students_register() public {
        attendance.addStudent("Charlie", 19);
        attendance.addStudent("Diana", 22);
        attendance.addStudent("Eve", 20);
        
        assertEq(attendance.getTotalStudents(), 3);
    }

    function test_frank_and_grace_have_different_attendance() public {
        attendance.addStudent("Frank", 18);
        attendance.addStudent("Grace", 23);
        
        attendance.updateAttendance(0, true);
        attendance.updateAttendance(1, false);
        
        (,, bool present1) = attendance.getStudent(0);
        (,, bool present2) = attendance.getStudent(1);
        
        assertTrue(present1);
        assertFalse(present2);
    }

    function test_cannot_find_student_that_doesnt_exist() public {
        vm.expectRevert("Student does not exist");
        attendance.getStudent(0);
    }

    function test_marking_attendance_for_ghost_student_fails() public {
        vm.expectRevert("Student does not exist");
        attendance.updateAttendance(0, true);
    }
}