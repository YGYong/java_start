package com.ygyong.task_manager;

import com.ygyong.task_manager.dto.PageResponse;

import java.util.ArrayList;
import java.util.List;

public class GenericPractice {
    public static void main(String[] args) {
        List<String> lists = new ArrayList<>();
        lists.add("学习泛型");
        lists.add("整理笔记");

        PageResponse<String> pageResponse = new PageResponse<>(lists, 2, 1, 10);

        String str = pageResponse.getItems().get(0);

        System.out.println(str);
        System.out.println(pageResponse.getTotal());
    }
}
