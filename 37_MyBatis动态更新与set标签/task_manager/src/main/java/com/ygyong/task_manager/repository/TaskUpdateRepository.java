package com.ygyong.task_manager.repository;

import com.ygyong.task_manager.mapper.TaskMapper;
import org.springframework.stereotype.Repository;

@Repository
public class TaskUpdateRepository {
    private final TaskMapper taskMapper;

    public TaskUpdateRepository(TaskMapper taskMapper) {
        this.taskMapper = taskMapper;
    }

    public int updateTask(int taskId, String title, Boolean completed) {
        return taskMapper.updateTask(taskId, title, completed);
    }

    public int updateCompleted(int taskId, Boolean completed) {
        return taskMapper.updateCompleted(taskId, completed);
    }
}
