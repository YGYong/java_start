package com.ygyong.task_manager.controller;

import com.ygyong.task_manager.dto.TaskResponse;
import com.ygyong.task_manager.service.TaskService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TaskController {
    private final TaskService taskService;


    public TaskController(TaskService taskService) {
        this.taskService = taskService;
    }

    @GetMapping("/tasks/count")
    public int getTaskCount() {
        return taskService.getTaskCount();
    }

    @GetMapping("/tasks/{id}")
    public TaskResponse getTaskById(@PathVariable("id") int taskId) {
        return taskService.getTaskById(taskId);
    }
}
