package com.ygyong.task_manager.controller;

import com.ygyong.task_manager.dto.*;
import com.ygyong.task_manager.service.TaskService;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

import java.util.List;

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

    @PostMapping("/tasks")
    public TaskResponse createTask(@RequestBody CreateTaskRequest request) {
        return taskService.createTask(request.getTitle());
    }

    @PatchMapping("/tasks/{id}/completed")
    public TaskResponse updateTaskCompleted(@PathVariable("id") int taskId, @RequestBody UpdateTaskCompletedRequest request) {
        return taskService.updateTaskCompleted(taskId, request.getCompleted());
    }

    @DeleteMapping("/tasks/{id}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void deleteTask(@PathVariable("id") int taskId) {
        // 调用 Service
        taskService.deleteTask(taskId);
    }

    @GetMapping("/tasks")
    public PageResponse<TaskResponse> getTasks(@ModelAttribute TaskQueryRequest query) {
        return taskService.getTasks(query.getCompleted(), query.getKeyword(), query.getPage(), query.getSize());
    }
}
