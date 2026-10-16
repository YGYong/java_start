package com.ygyong.task_manager.service;

import com.ygyong.task_manager.dto.TaskResponse;
import org.springframework.stereotype.Service;

@Service
public class TaskService {
    public int getTaskCount() {
        return 0;
    }

    public TaskResponse getTaskById(int taskId) {
        return new TaskResponse(taskId, "学习 HTTP 参数", false);
    }
}
