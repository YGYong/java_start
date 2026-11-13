package com.ygyong.task_manager.controller;

import com.ygyong.task_manager.service.TaskDeleteService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TaskDeleteController {
    private final TaskDeleteService taskDeleteService;

    public TaskDeleteController(TaskDeleteService taskDeleteService) {
        this.taskDeleteService = taskDeleteService;
    }

    @DeleteMapping("/database/tasks/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteTaskById(@PathVariable int id) {
        taskDeleteService.deleteTask(id);
    }
}
