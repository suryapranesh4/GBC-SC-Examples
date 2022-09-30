//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract stuview {
    struct Student {
        string name;
        uint class;
        uint enrollDate;
    }

    address public teacher;

    uint StudentNum;

    event Added(string name, uint class, uint enrollDate);

    mapping(uint => Student) public stuView;

    modifier isTeacher() {
        require(
            msg.sender == teacher,
            "Only Teacher is allowed to enroll a student"
        );
        _;
    }

    constructor() {
        teacher = msg.sender;
    }

    function addStudent(
        string memory name,
        uint class,
        uint enrollDate
    ) public isTeacher {
        require(class > 0 && class <= 7, "Invalid class #");
        Student memory student = Student(name, class, enrollDate);
        StudentNum++;
        stuView[StudentNum] = student;
        emit Added(name, class, block.timestamp);
    }
}
