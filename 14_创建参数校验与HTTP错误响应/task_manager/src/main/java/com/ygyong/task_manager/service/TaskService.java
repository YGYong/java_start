package com.ygyong.task_manager.service;

import com.ygyong.task_manager.dto.TaskResponse;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class TaskService {
    private final List<TaskResponse> tasks = new ArrayList<>();
    private int nextId = 1;

    public int getTaskCount() {
        return tasks.size();
    }

    public TaskResponse getTaskById(int taskId) {
        return new TaskResponse(taskId, "学习 HTTP 参数", false);
    }

    public TaskResponse createTask(String title) {

        // 校验空字符串或者null
        if(title == null || title.isBlank()) {
            throw new IllegalArgumentException("任务标题不能为空");
        }

        TaskResponse newTask = new TaskResponse(nextId++, title, false);
        tasks.add(newTask);
        return newTask;
    }
}
