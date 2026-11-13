package com.ygyong.task_manager.service;

import com.ygyong.task_manager.dto.PageResponse;
import com.ygyong.task_manager.dto.TaskResponse;

public interface TaskService {
    int getTaskCount();

    TaskResponse getTaskById(int taskId);

    TaskResponse createTask(String title);

    TaskResponse updateTaskCompleted(int taskId, Boolean completed);

    void deleteTask(int taskId);

    PageResponse<TaskResponse> getTasks(Boolean completed, String keyword, Integer page, Integer size);
}
