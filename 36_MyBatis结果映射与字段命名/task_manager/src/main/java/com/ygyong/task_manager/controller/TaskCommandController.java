package com.ygyong.task_manager.controller;

import com.ygyong.task_manager.dto.CreateTaskRequest;
import com.ygyong.task_manager.dto.TaskResponse;
import com.ygyong.task_manager.service.TaskCommandService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TaskCommandController {
    private final TaskCommandService taskCommandService;

    public TaskCommandController(TaskCommandService taskCommandService) {
        this.taskCommandService = taskCommandService;
    }

    @PostMapping("/database/tasks")
    public TaskResponse createTask(@RequestBody CreateTaskRequest request) {
        TaskResponse taskResponse = taskCommandService.createTask(request.getTitle());
        return taskResponse;
    }
}
