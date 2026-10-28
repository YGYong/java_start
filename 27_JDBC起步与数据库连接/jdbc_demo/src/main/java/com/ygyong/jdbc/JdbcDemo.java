package com.ygyong.jdbc;

import java.sql.*;

public class JdbcDemo {
    public static void main(String[] args) throws SQLException {
        String url = "jdbc:mysql://localhost:3306/testspring";
        String username = "root";
        String password = System.getenv("DB_PASSWORD");

        try (Connection connection =
                     DriverManager.getConnection(url, username, password)) {
            // 在这里使用连接

            String sql = "SELECT id, title, completed FROM task ORDER BY id";

            try (PreparedStatement statement =connection.prepareStatement(sql) /* 创建查询对象 */;
                 ResultSet resultSet =statement.executeQuery() /* 执行查询 */) {
                // 遍历结果
                while (resultSet.next()) {
                    // 读取当前行并打印
                    int id = resultSet.getInt("id");
                    String title =  resultSet.getString("title");
                    boolean completed = resultSet.getBoolean("completed");

                    System.out.println("任务ID：" + id + "，标题：" + title + "，完成状态：" + completed);
                }
            }

            System.out.println("连接成功，当前数据库：" + connection.getCatalog());
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
