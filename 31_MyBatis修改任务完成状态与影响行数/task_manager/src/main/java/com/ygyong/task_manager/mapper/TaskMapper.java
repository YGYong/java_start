package com.ygyong.task_manager.mapper;

import com.ygyong.task_manager.entity.Task;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface TaskMapper {
    @Select("SELECT id, title, completed FROM task ORDER BY id")
    List<Task> findAll();

    @Select("SELECT id, title, completed FROM task WHERE id = #{id}")
    Task findById(@Param("id") int id);

    @Insert("INSERT INTO task (title, completed) VALUES (#{title}, #{completed})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Task task);

    @Update("UPDATE task SET completed = #{completed} WHERE id = #{id}")
    int updateCompleted(@Param("id") int id, @Param("completed") boolean completed);
}