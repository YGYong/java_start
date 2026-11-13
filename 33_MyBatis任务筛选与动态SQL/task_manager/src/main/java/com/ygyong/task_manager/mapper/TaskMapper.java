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

    @Delete("DELETE FROM task WHERE id = #{id}")
    int deleteById(@Param("id") int id);


    //查询字段仍然是 id, title, completed。
    //两个 <if> 都放进 <where>。
    //关键词不为 null、不为空字符串时才加入标题条件。
    //标题包含查询可以使用 LIKE CONCAT('%', #{keyword}, '%')，继续使用 #{} 绑定值。
    //ORDER BY id 放在 </where> 后面，保证有无条件都排序。
    @Select("<script>" +
            "SELECT id, title, completed FROM task" +
            "<where>" +
            "<if test='completed != null'>" +
            " AND completed = #{completed}" +
            "</if>" +
            "<if test='keyword != null and keyword != \"\"'>" +
            " AND title LIKE CONCAT('%', #{keyword}, '%')" +
            "</if>" +
            "</where>" +
            "ORDER BY id" +
            "</script>")
    List<Task> findByConditions(
            @Param("completed") Boolean completed,
            @Param("keyword") String keyword);
}