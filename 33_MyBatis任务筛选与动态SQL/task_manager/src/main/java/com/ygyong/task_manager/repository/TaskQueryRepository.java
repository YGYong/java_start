package com.ygyong.task_manager.repository;

import com.ygyong.task_manager.entity.Task;
import com.ygyong.task_manager.mapper.TaskMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TaskQueryRepository {
    private final TaskMapper taskMapper;

    public TaskQueryRepository(TaskMapper taskMapper) {
        this.taskMapper = taskMapper;
    }

    public List<Task> findAll() {
        return taskMapper.findAll();
    }

    public Task findById(int id) {
        return taskMapper.findById(id);
    }

    public List<Task> findByConditions(Boolean completed,String keyword) {
        return taskMapper.findByConditions(completed,keyword);
    }
}
