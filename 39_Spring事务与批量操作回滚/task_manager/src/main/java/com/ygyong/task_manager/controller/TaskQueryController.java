package com.ygyong.task_manager.controller;

import com.ygyong.task_manager.dto.TaskResponse;
import com.ygyong.task_manager.dto.PageResponse;
import com.ygyong.task_manager.service.TaskQueryService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TaskQueryController {
    private final TaskQueryService taskQueryService;

    public TaskQueryController(TaskQueryService taskQueryService) {
        this.taskQueryService = taskQueryService;
    }

    @GetMapping("/database/tasks")
    public PageResponse<TaskResponse> getTasks(
            @RequestParam(value = "completed", required = false) Boolean completed,
            @RequestParam(value = "keyword", required = false) String keyword,
            @RequestParam(value = "page", defaultValue = "1") int page,
            @RequestParam(value = "size", defaultValue = "10") int size
    ) {
        return taskQueryService.getTasks(completed, keyword, page, size);
    }

    @GetMapping("/database/tasks/{id}")
    public TaskResponse getTaskById(@PathVariable int id) {
        return taskQueryService.getTaskById(id);
    }
}
