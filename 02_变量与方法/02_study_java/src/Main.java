public class Main {
    public static void main(String[] args) {
        int remainingTasks =  calculateRemainingTasks(8,3);
        int remainingTasks2 =  calculateRemainingTasks(8,8);
        System.out.println("是否全部完成：" + isAllCompleted(remainingTasks));
        System.out.println("是否全部完成：" + isAllCompleted(remainingTasks2));
    }

    static int calculateRemainingTasks(int totalTasks, int completedTasks) {
        return totalTasks - completedTasks;
    }

    static boolean isAllCompleted(int remainingTasks) {
        return remainingTasks == 0;
    }
}