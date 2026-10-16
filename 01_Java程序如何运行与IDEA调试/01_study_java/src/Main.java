//TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or
// click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.
public class Main {
    public static void main(String[] args) {
        // 总任务数 5
        int totalTasks = 5;
        // 已完成数 2
        int completedTasks = 2;
        // 总任务数减去已完成数
        int remainingTasks = totalTasks - completedTasks;

        System.out.println("数量：" + remainingTasks);
    }
}