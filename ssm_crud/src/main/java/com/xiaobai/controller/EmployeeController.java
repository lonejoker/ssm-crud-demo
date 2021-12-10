package com.xiaobai.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.xiaobai.bean.Employee;
import com.xiaobai.bean.Msg;
import com.xiaobai.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
* @author 终于白发始于青丝
* @Classname EmployeeController
* @Description 类方法说明：处理员工CRUD请求
*/
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    /**
     * @author 终于白发始于青丝
     * @Methodname deleteEmpById
     * @Description 类方法说明：员工删除
     * @Return 返回值：com.xiaobai.bean.Msg
     * @Params java.lang.String ids
     */
    @RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
    @ResponseBody
    public Msg deleteEmpById(@PathVariable("ids") String ids) {
        if (ids.contains("-")) { // 批量删除
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            // 组装id集合
            for (String string : str_ids) {
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);

        } else {
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    /**
     * 如果直接发送ajax=PUT形式的请求
     * 封装的数据
     * Employee
     *     [empId=1, empName=null, gender=null, email=null, dId=null]
     * 问题：
     *     请求体中有数据
     *         但是Employee对象封装不上
     *         update tbl_emp  where emp_id = 1;
     * 原因：
     *     Tomcat：
     *         1、将请求体中的数据，封装一个map
     *         2、request.getParameter("empName")就会从这个map中取值
     *         3、SpringMVC封装POJO对象的时候
     *         会把POJO中每个属性的值，request.getParamter("email");
     * AJAX发送PUT请求引发的血案：
     *      PUT请求，请求体中的数据，request.getParameter("empName")拿不到
     *      Tomcat一看是PUT不会封装请求体中的数据为map，只有POST形式的请求才封装请求体为map
     *      org.apache.catalina.connector.Request--parseParameters() (3111);
     *      protected String parseBodyMethods = "POST";
     *      if( !getConnector().isParseBodyMethod(getMethod()) ) {
     *          success = true;
     *          return;
     *      }
     * 解决方案；
     *      我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     *      1、配置上HttpPutFormContentFilter；
     *      2、他的作用；将请求体中的数据解析包装成一个map。
     *      3、request被重新包装，request.getParameter()被重写，就会从自己封装的map中取数据
     */
    /**
     * @author 终于白发始于青丝
     * @Methodname saveEmp
     * @Description 类方法说明：员工更新
     * @Return 返回值：com.xiaobai.bean.Msg
     * @Params com.xiaobai.bean.Employee employee
     * @Params javax.servlet.http.HttpServletRequest request
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee, HttpServletRequest request) {
        System.out.println("请求体中的值：" + request.getParameter("gender"));
        System.out.println("将要更新的员工数据：" + employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * @author 终于白发始于青丝
     * @Methodname getEmp
     * @Description 类方法说明：根据id查询员工信息
     * @Return 返回值：com.xiaobai.bean.Msg
     * @Params java.lang.Integer id
     */
    @RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    /**
     * @author 终于白发始于青丝
     * @Methodname checkUser
     * @Description 类方法说明：检查用户名是否可用
     * @Return 返回值：com.xiaobai.bean.Msg
     * @Params java.lang.String empName
     */
    @RequestMapping("/checkuser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName) {
        // 先判断用户名是否是合法的表达式
        String regName = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})";
        if (!empName.matches(regName)) {
            return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文 ");
        }
        // 数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    /**
     * @author 终于白发始于青丝
     * @Methodname saveEmp
     * @Description 类方法说明： 员工保存 1、支持JSR303校验        2、导入Hibernate-Validator
     * @Return 返回值：com.xiaobai.bean.Msg
     * @Params com.xiaobai.bean.Employee employee
     * @Params org.springframework.validation.BindingResult result
     */
    @RequestMapping(value = "/emp", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            // 如果校验失败，应该返回失败，在模态框中显示校验失败的错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名：" + fieldError.getField());
                System.out.println("错误信息：" + fieldError.getDefaultMessage());
                // 将错误信息添加到map中
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        // 这不是一个分页查询
        // 引入PageHelper分页插件
        // 在查询之前需要调用，传入页码以及每页的大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询是分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        // 封装了详细的分页信息，包括查询出来的数据,传入需要显示的页数
        PageInfo page = new PageInfo(emps, 5);
        return Msg.success().add("pageInfo", page);
    }

    /**
     * @author 终于白发始于青丝
     * @Methodname getEmps
     * @Description 类方法说明：查询员工数据，分页查询
     * @Return 返回值：java.lang.String
     * @Params java.lang.Integer pn
     * @Params org.springframework.ui.Model model
     * @Date 2021/12/10 上午 10:55
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        // 这不是一个分页查询
        // 引入PageHelper分页插件
        // 在查询之前需要调用，传入页码以及每页的大小
        PageHelper.startPage(pn, 5);
        // startPage后面紧跟的这个查询是分页查询
        List<Employee> emps = employeeService.getAll();
        // 使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        // 封装了详细的分页信息，包括查询出来的数据,传入需要显示的页数
        PageInfo page = new PageInfo(emps, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }
}
