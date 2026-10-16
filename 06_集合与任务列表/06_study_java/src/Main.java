import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {

        ArrayList<Task> tasks = new ArrayList<>();

        tasks.add(new Task("标题1"));
        tasks.add(new Task("标题2"));
        tasks.add(new Task("标题3"));

        tasks.get(1).markCompleted();

        int remainingTasks = 0;

        for(Task task:tasks) {
            System.out.println("标题：" + task.getTitle() + " 完成状态：" + task.isCompleted());
            if(!task.isCompleted()) {
                ++remainingTasks;
            }
        }
        System.out.println("剩余任务数：" + remainingTasks);
    }
}