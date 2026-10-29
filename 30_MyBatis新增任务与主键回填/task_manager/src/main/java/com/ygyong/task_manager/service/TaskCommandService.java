package com.ygyong.task_manager.service;

import com.ygyong.task_manager.dto.TaskResponse;
import com.ygyong.task_manager.entity.Task;
import com.ygyong.task_manager.repository.TaskCommandRepository;
import org.springframework.stereotype.Service;

@Service
public class TaskCommandService {
    private final TaskCommandRepository taskCommandRepository;

    public TaskCommandService(TaskCommandRepository taskCommandRepository) {
        this.taskCommandRepository = taskCommandRepository;
    }

    public TaskResponse createTask(String title) {
       if (title == null || title.isBlank()) {
            throw new IllegalArgumentException("任务标题不能为空");
        }
        if (title.length() > 100) {
            throw new IllegalArgumentException("任务标题不能超过100个字符");
        }

        // 创建task
        Task task = new Task();
        task.setTitle(title);
        task.setCompleted(false);

        int num = taskCommandRepository.insert(task);

        if(num != 1) {
            throw new IllegalStateException("新增任务失败，影响行数异常");
        }

        TaskResponse taskResponse = new TaskResponse(task.getId(), task.getTitle(), task.isCompleted());
        return taskResponse;
    }
}
