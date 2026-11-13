package com.ygyong.task_manager.controller;

import com.ygyong.task_manager.dto.BatchDeleteTaskRequest;
import com.ygyong.task_manager.service.TaskDeleteService;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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

    @PostMapping("/database/tasks/batch-delete")
    public int deleteTasks(@RequestBody BatchDeleteTaskRequest request) {
        if (request == null) {
            throw new IllegalArgumentException("请求体不能为空");
        }
        return taskDeleteService.deleteTasks(request.getIds());
    }

    @DeleteMapping("/database/tasks/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteTaskById(@PathVariable int id) {
        taskDeleteService.deleteTask(id);
    }
}
