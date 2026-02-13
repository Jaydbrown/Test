// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StudentAttendance {
    struct Student {
        string name;
        uint8 age;
        bool present;
    }

    Student[] public students;

    // Events
    event StudentAdded(uint256 indexed studentId, string name, uint8 age);
    event AttendanceUpdated(uint256 indexed studentId, bool present);

    function addStudent(string memory _name, uint8 _age) public {
        students.push(Student({
            name: _name,
            age: _age,
            present: false
        }));

        emit StudentAdded(students.length - 1, _name, _age);
    }

    function updateAttendance(uint256 _studentId, bool _present) public {
        require(_studentId < students.length, "Student does not exist");
        
        students[_studentId].present = _present;
        
        emit AttendanceUpdated(_studentId, _present);
    }

    function getTotalStudents() public view returns (uint256) {
        return students.length;
    }

    function getStudent(uint256 _studentId) public view returns (string memory name, uint8 age, bool present) {
        require(_studentId < students.length, "Student does not exist");
        Student memory student = students[_studentId];
        return (student.name, student.age, student.present);
    }
}