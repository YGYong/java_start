package com.ygyong.task_manager.repository;

import com.ygyong.task_manager.mapper.TaskMapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class TaskDeleteRepository {
    private final TaskMapper taskMapper;

    public TaskDeleteRepository(TaskMapper taskMapper) {
        this.taskMapper = taskMapper;
    }

    public int deleteByIds(List<Integer> ids) {
        return taskMapper.deleteByIds(ids);
    }

    public int deleteById(int id) {
        return taskMapper.deleteById(id);
    }
}
