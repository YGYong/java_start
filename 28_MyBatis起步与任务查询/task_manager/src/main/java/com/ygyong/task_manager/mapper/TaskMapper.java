package com.ygyong.task_manager.mapper;

import com.ygyong.task_manager.entity.Task;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface TaskMapper {
    @Select("SELECT id, title, completed FROM task ORDER BY id")
    List<Task> findAll();
}