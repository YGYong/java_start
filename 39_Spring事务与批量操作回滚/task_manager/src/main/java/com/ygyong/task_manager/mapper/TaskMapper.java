package com.ygyong.task_manager.mapper;

import com.ygyong.task_manager.entity.Task;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface TaskMapper {
    // 查询 SQL 位于 resources/mapper/TaskMapper.xml，方法名与 select 的 id 对应。
    List<Task> findAll();

    Task findById(@Param("id") int id);

    List<Task> findByConditions(
            @Param("completed") Boolean completed,
            @Param("keyword") String keyword);

    List<Task> findPageByConditions(
            @Param("completed") Boolean completed,
            @Param("keyword") String keyword,
            @Param("size") int size,
            @Param("offset") long offset);

    long countByConditions(
            @Param("completed") Boolean completed,
            @Param("keyword") String keyword);

    @Insert("INSERT INTO task (title, completed) VALUES (#{title}, #{completed})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(Task task);

    // 对应 XML 中的 update id="updateTask"。
    int updateTask(@Param("id") int id,
                   @Param("title") String title,
                   @Param("completed") Boolean completed);

    @Update("UPDATE task SET completed = #{completed} WHERE id = #{id}")
    int updateCompleted(@Param("id") int id, @Param("completed") boolean completed);

    // 对应 XML 中的 delete id="deleteByIds"，ids 是集合在 XML 中的名称。
    int deleteByIds(@Param("ids") List<Integer> ids);

    @Delete("DELETE FROM task WHERE id = #{id}")
    int deleteById(@Param("id") int id);
}
