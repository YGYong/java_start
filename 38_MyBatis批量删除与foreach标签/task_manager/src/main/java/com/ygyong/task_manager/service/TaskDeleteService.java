package com.ygyong.task_manager.service;

import com.ygyong.task_manager.exception.TaskNotFoundException;
import com.ygyong.task_manager.repository.TaskDeleteRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TaskDeleteService {
    private final TaskDeleteRepository taskDeleteRepository;

    public TaskDeleteService(TaskDeleteRepository taskDeleteRepository) {
        this.taskDeleteRepository = taskDeleteRepository;
    }

    // 先验证整个列表，再执行一条 SQL，避免遇到非法编号前已删除部分任务。
    public int deleteTasks(List<Integer> ids) {
        if (ids == null || ids.isEmpty()) {
            throw new IllegalArgumentException("任务编号列表不能为空");
        }
        if (ids.size() > 100) {
            throw new IllegalArgumentException("一次最多提交100个任务编号");
        }
        for (Integer id : ids) {
            if (id == null || id <= 0) {
                throw new IllegalArgumentException("任务编号必须是正整数");
            }
        }
        return taskDeleteRepository.deleteByIds(ids);
    }

    public boolean deleteTask(int id) {
        int rowsAffected = taskDeleteRepository.deleteById(id);

        if(rowsAffected == 1) {
            return true;
        }else if(rowsAffected == 0) {
            throw new TaskNotFoundException("Task with id " + id + " does not exist.");
        }else {
            throw new IllegalStateException("Unexpected number of rows affected: " + rowsAffected);
        }
    }
}
