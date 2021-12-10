package com.xiaobai.service;

import com.xiaobai.bean.Employee;
import com.xiaobai.bean.EmployeeExample;
import com.xiaobai.bean.EmployeeExample.Criteria;
import com.xiaobai.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
    * @author 终于白发始于青丝
    * @Classname EmployeeService
    * @Description 类方法说明：查询所有员工
    */
    public List<Employee> getAll() {

        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
    * @author 终于白发始于青丝
    * @Classname EmployeeService
    * @Description 类方法说明：员工保存
    */
    public void saveEmp(Employee employee) {
        // 有选择的插入
        employeeMapper.insertSelective(employee);
    }

    /**
    * @author 终于白发始于青丝
    * @Classname EmployeeService
    * @Description 类方法说明：检验用户名是否可用   true表示当前用户可用
    */
    public boolean checkUser(String empName) {

        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        // 记录数
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    /**
    * @author 终于白发始于青丝
    * @Classname EmployeeService
    * @Description 类方法说明：根据员工id查询员工
    */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
    * @author 终于白发始于青丝
    * @Classname EmployeeService
    * @Description 类方法说明：员工更新
    */
    public void updateEmp(Employee employee) {

        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
    * @author 终于白发始于青丝
    * @Classname EmployeeService
    * @Description 类方法说明：员工删除
    */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
    * @author 终于白发始于青丝
    * @Classname EmployeeService
    * @Description 类方法说明：批量删除
    */
    public void deleteBatch(List<Integer> ids) {
        EmployeeExample example = new EmployeeExample();
        Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(example);
    }
}
