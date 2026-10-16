public class Main {
    public static void main(String[] args) {
        int totalTasks = 8;
        int completedTasks = 10;
        boolean isValid =  isValidTaskCounts(totalTasks,completedTasks);
        if(isValid) {
            System.out.println(calculateRemainingTasks(totalTasks,completedTasks));
        }else {
            System.out.println("值不合法");
        }
    }

    static int calculateRemainingTasks(int totalTasks, int completedTasks) {
        return totalTasks - completedTasks;
    }


    static boolean isValidTaskCounts(int totalTasks, int completedTasks) {
        return completedTasks >= 0 && totalTasks >= completedTasks; // 任务数不能为负数
    }
}