pragma solidity ^0.8.0;

contract TaskManagement {
    address payable owner;
    mapping(bytes32 => Task) public tasks;
    struct Task {
        bytes32 taskId;
        address assignedTo;
        bool completed;
    }

    event TaskCreated(bytes32 indexed taskId);
    event TaskAssigned(bytes32 indexed taskId, address indexed assignedTo);
    event TaskCompleted(bytes32 indexed taskId, address indexed assignedTo);

    constructor() public {
        owner = msg.sender;
    }

    function createTask(bytes32 _taskId) public {
        require(msg.sender == owner, "Only owner can create tasks");
        require(tasks[_taskId].taskId == 0, "Task already exists");
        tasks[_taskId] = Task(_taskId, address(0), false);
        emit TaskCreated(_taskId);
    }

    function assignTask(bytes32 _taskId, address _assignedTo) public {
        require(msg.sender == owner, "Only owner can assign tasks");
        require(tasks[_taskId].taskId != 0, "Task does not exist");
        require(tasks[_taskId].assignedTo == address(0), "Task already assigned");
        tasks[_taskId].assignedTo = _assignedTo;
        emit TaskAssigned(_taskId, _assignedTo);
    }

    function completeTask(bytes32 _taskId) public {
        require(msg.sender == tasks[_taskId].assignedTo, "Only assigned user can complete task");
        require(tasks[_taskId].completed == false, "Task already completed");
        tasks[_taskId].completed = true;
        emit TaskCompleted(_taskId, tasks[_taskId].assignedTo);
    }
}

/*
Smart contract for a decentralized task management system where users can create, assign and complete tasks. The smart contract will ensure that tasks are assigned to the right person, and that the person who completes the task gets rewarded.

This smart contract allows the owner of the contract to create tasks, assign them to a specific address, and mark the task as completed. Anyone can view the task by searching their taskId, and only the person who assigned to the task can complete it. Also, the smart contract emits events when a task is created, assigned and completed, so that the front-end can listen to these events to update the user interface.
*/