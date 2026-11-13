package com.ygyong.task_manager.repository;

import com.ygyong.task_manager.mapper.TaskMapper;
import org.springframework.stereotype.Repository;

@Repository
public class TaskDeleteRepository {
    private final TaskMapper taskMapper;

    public TaskDeleteRepository(TaskMapper taskMapper) {
        this.taskMapper = taskMapper;
    }

    public int deleteById(int id) {
        return taskMapper.deleteById(id);
    }
}
