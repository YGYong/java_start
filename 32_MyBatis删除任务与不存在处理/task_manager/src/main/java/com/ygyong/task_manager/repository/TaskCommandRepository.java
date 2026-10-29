package com.ygyong.task_manager.repository;

import com.ygyong.task_manager.entity.Task;
import com.ygyong.task_manager.mapper.TaskMapper;
import org.springframework.stereotype.Repository;

@Repository
public class TaskCommandRepository {
    private final TaskMapper taskMapper;

    public TaskCommandRepository(TaskMapper taskMapper) {
        this.taskMapper = taskMapper;
    }

    public int insert(Task task) {
        return taskMapper.insert(task);
    }
}
