package com.ygyong;

public class Main {
    public static void main(String[] args) {
        TaskService service = new InMemoryTaskService();

        Task task = service.addTask("学习Java接口");

        System.out.println(task.getTitle());
        task.markCompleted();

        try {
            service.addTask("");
        } catch (IllegalArgumentException e) {
            System.out.println(e.getMessage());
        }

        service.addTask("学习Java接口2222");

        task.markCompleted();
        System.out.println("未完成数量：" + service.getRemainingTaskCount());
        System.out.println("未完成数量：" + service.getRemainingTaskCount());

        System.out.println("总数：" + service.getTaskCount());
    }
}
