package com.ygyong.task_manager.controller;

import com.ygyong.task_manager.dto.TaskResponse;
import com.ygyong.task_manager.service.TaskQueryService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class TaskQueryController {
    private final TaskQueryService taskQueryService;

    public TaskQueryController(TaskQueryService taskQueryService) {
        this.taskQueryService = taskQueryService;
    }

    @GetMapping("/database/tasks")
    public List<TaskResponse> getTasks() {
        return taskQueryService.getTasks();
    }
}
