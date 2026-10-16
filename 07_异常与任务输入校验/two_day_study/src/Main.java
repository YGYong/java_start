import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        ArrayList<Task> tasks = new ArrayList<>();
        tasks.add(new Task("学习异常处理"));
        try {
            tasks.add(new Task(""));
            System.out.println("非法任务添加之后");
        } catch (IllegalArgumentException e) {
            System.out.println("创建失败：" + e.getMessage());
        }
        tasks.add(new Task("练习任务校验"));
        System.out.println("数量：" + tasks.size());

        for(Task task:tasks) {
            System.out.println("标题：" + task.getTitle());
        }
    }
}
