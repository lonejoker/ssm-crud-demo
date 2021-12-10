package com.xiaobai.controller;

import com.xiaobai.bean.Department;
import com.xiaobai.bean.Msg;
import com.xiaobai.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
* @author 终于白发始于青丝
* @Classname DepartmentController
* @Description 类方法说明：处理和部门有关的请求
*/
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    /**
    * @author 终于白发始于青丝
    * @Classname DepartmentController
    * @Description 类方法说明：返回所有的部门信息
    */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts() {
        // 显示所有的部门信息
        List<Department> list = departmentService.getDepts();
        return Msg.success().add("depts",list);
    }
}
