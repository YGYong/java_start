package com.ygyong.task_manager.controller;

import com.ygyong.task_manager.dto.BatchUpdateTaskCompletedRequest;
import com.ygyong.task_manager.dto.UpdateTaskCompletedRequest;
import com.ygyong.task_manager.dto.UpdateTaskRequest;
import com.ygyong.task_manager.service.TaskUpdateService;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TaskUpdateController {
    private final TaskUpdateService taskUpdateService;

    public TaskUpdateController(TaskUpdateService taskUpdateService) {
        this.taskUpdateService = taskUpdateService;
    }

    @PatchMapping("/database/tasks/{id}")
    public boolean updateTask(@PathVariable("id") int taskId, @RequestBody UpdateTaskRequest request) {
        return taskUpdateService.updateTask(taskId, request.getTitle(), request.getCompleted());
    }

    @PatchMapping("/database/tasks/{id}/completed")
    public boolean updateTaskCompleted(@PathVariable("id") int taskId, @RequestBody UpdateTaskCompletedRequest request) {
        return taskUpdateService.updateCompleted(taskId, request.getCompleted());
    }

    @PatchMapping("/database/tasks/batch-completed")
    public int batchUpdateCompleted(@RequestBody BatchUpdateTaskCompletedRequest request) {
        return taskUpdateService.batchUpdateCompleted(request.getIds(), request.getCompleted());
    }
}


