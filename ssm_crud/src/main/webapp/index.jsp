<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>员工系统</title>
        <% pageContext.setAttribute("APP_PATH", request.getContextPath()); %>
        <!--
            web路径：
                不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题
                以/开始的相对路径，找资源，以服务器的路径为标准(http://localhost:8080)；需要加上项目名
                http://localhost:8080/crud
        -->
        <script type="text/javascript" src="static/js/jquery3.4.1.min.js"></script>
        <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
        <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <!-- 员工修改的模态框 -->
        <div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title">员工修改</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">姓名</label>
                                <div class="col-sm-10"><p class="form-control-static" id="empName_update_static"></p>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">邮箱</label>
                                <div class="col-sm-10">
                                    <input type="text" name="email" class="form-control" id="email_update_input"
                                           placeholder="email@126.com">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">性别</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender1_update_input" value="G"
                                               checked="checked">男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender2_update_input" value="M"> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">部门</label>
                                <div class="col-sm-4">
                                    <!-- 部门不是写死，从数据库查询。部门提交部门id即可 -->
                                    <select class="form-control" name="dId">
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 员工添加的模态框 -->
        <div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title" id="myModalLabel">员工添加</h4>
                    </div>
                    <div class="modal-body">
                        <form class="form-horizontal">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">姓名</label>
                                <div class="col-sm-10">
                                    <input type="text" name="empName" class="form-control" id="empName_add_input"
                                           placeholder="请输入姓名">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">邮箱</label>
                                <div class="col-sm-10">
                                    <input type="text" name="email" class="form-control" id="email_add_input"
                                           placeholder="请输入邮箱（注意格式）">
                                    <span class="help-block"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">性别</label>
                                <div class="col-sm-10">
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender1_add_input" value="G"
                                               checked="checked"> 男
                                    </label>
                                    <label class="radio-inline">
                                        <input type="radio" name="gender" id="gender2_add_input" value="M"> 女
                                    </label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">部门</label>
                                <div class="col-sm-4">
                                    <!-- 部门不是写死，从数据库查询。部门提交部门id即可 -->
                                    <select class="form-control" name="dId">
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                        <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- 搭建显示页面 -->
        <div class="container">
            <!-- 标题 -->
            <div class="row">
                <div class="col-md-12">
                    <h1 style="text-align:center;">员工系统</h1>
                </div>
            </div>
            <!-- 按钮 -->
            <div class="row">
                <div class="col-md-4 col-md-offset-8">
                    <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
                    <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
                </div>
            </div>
            <!-- 显示表格数据 -->
            <div class="row">
                <div class="col-md-12">
                    <table class="table table-hover" id="emps_table">
                        <thead>
                        <tr>
                            <th>
                                <input type="checkbox" id="check_all"/>
                            </th>
                            <th>编号</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>邮箱</th>
                            <th>部门</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <!-- 显示分页信息 -->
            <div class="row">
                <!-- 分页文字信息 -->
                <div class="col-md-6" id="page_info_area">
                </div>
                <!-- 分页导航条信息 -->
                <div class="col-md-6" id="page_nav_area">
                    <nav aria-label="Page navigation">
                        <ul class="pagination">
                        </ul>
                    </nav>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            // 定义全局变量，显示总记录数和当前页
            var totalRecord, currentPage;
            // 页面加载完成以后，发送Ajax请求，要到分页数据
            $(function () {
                // 跳到首页
                to_page(1);
            });

            function to_page(pn) {
                $.ajax({
                    url: "${APP_PATH}/emps",
                    data: "pn=" + pn,
                    type: "get",
                    success: function (result) {
                        //console.log(result)
                        // 解析并显示员工数据
                        build_emps_table(result);
                        // 解析并显示分页信息
                        build_page_info(result);
                        // 解析并显示分页条
                        build_page_nav(result);
                    }
                })
            }

            function build_emps_table(result) {
                // 清空表格
                $("#emps_table tbody").empty();
                var emps = result.extend.pageInfo.list;
                // 遍历员工数据 index是索引，item是当前对象
                $.each(emps, function (index, item) {
                    var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                    var empIdTd = $("<td></td>").append(item.empId);
                    var empNameTd = $("<td></td>").append(item.empName);
                    var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
                    var emailTd = $("<td></td>").append(item.email);
                    var deptNameTd = $("<td></td>").append(item.department.deptName);
                    var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-pencil"))
                        .append("编辑");
                    // 为编辑按钮添加一个自定义的属性，来表示当前员工的id
                    editBtn.attr("edit-id", item.empId);
                    var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                        .append($("<span></span>").addClass("glyphicon glyphicon-trash"))
                        .append("删除");
                    // 为删除按钮添加一个自定义的属性，来表示当前需要删除员工的id
                    delBtn.attr("del-id", item.empId)
                    var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
                    // append 方法执行完成以后还是返回原来的元素
                    $("<tr></tr>").append(checkBoxTd)
                        .append(empIdTd)
                        .append(empNameTd)
                        .append(genderTd)
                        .append(emailTd)
                        .append(deptNameTd)
                        .append(btnTd)
                        .appendTo("#emps_table tbody");
                })
            }

            // 解析显示分页信息
            function build_page_info(result) {
                $("#page_info_area").empty();
                $("#page_info_area").append("当前 " + result.extend.pageInfo.pageNum + " 页，" +
                    "总 " + result.extend.pageInfo.pages + " 页，总 " + result.extend.pageInfo.total + " 条记录");
                totalRecord = result.extend.pageInfo.total;
                currentPage = result.extend.pageInfo.pageNum;
            }

            // 解析显示分页导航条
            function build_page_nav(result) {
                $("#page_nav_area").empty();
                var ul = $("<ul></ul>").addClass("pagination")
                // 首页li
                var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));
                // 前一页li
                var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));
                // 判断有没有前一页
                if (result.extend.pageInfo.hasPreviousPage == false) {
                    firstPageLi.addClass("disabled");
                    prePageLi.addClass("disabled");
                } else {
                    // 为元素添加翻页的事件
                    firstPageLi.click(function () {
                        to_page(1)
                    });
                    prePageLi.click(function () {
                        to_page(result.extend.pageInfo.pageNum - 1);
                    });
                }
                // 后一页li
                var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));
                // 末页li
                var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));
                // 判断有没有下一页
                if (result.extend.pageInfo.hasNextPage == false) {
                    nextPageLi.addClass("disabled");
                    lastPageLi.addClass("disabled");
                } else {
                    nextPageLi.click(function () {
                        to_page(result.extend.pageInfo.pageNum + 1);
                    });
                    lastPageLi.click(function () {
                        to_page(result.extend.pageInfo.pages);
                    });
                }
                // 添加首页和前一页的提示
                ul.append(firstPageLi).append(prePageLi);
                // 遍历给ul中添加页码提示
                $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
                    var numLi = $("<li></li>").append($("<a></a>").append(item));
                    if (result.extend.pageInfo.pageNum == item) {
                        numLi.addClass("active");
                    }
                    numLi.click(function () {
                        to_page(item);
                    })
                    ul.append(numLi);
                });
                // 添加下一页和末页的提示
                ul.append(nextPageLi).append(lastPageLi);
                // 把ul加入到nav元素中
                var navEle = $("<nav></nav>").append(ul);
                navEle.appendTo("#page_nav_area");
            }

            // 清空表单样式及内容
            function reset_form(ele) {
                $(ele)[0].reset();
                // 清空表单样式
                $(ele).find("*").removeClass("has-error has-success");
                $(ele).find(".help-block").text("");
            }

            // 点击新增按钮，弹出模态框
            $("#emp_add_modal_btn").click(function () {
                // 点击新增弹出模态框之前，清空表单数据以及表单的样式
                reset_form("#empAddModal form");
                $("#empAddModal form");
                // [0].reset(); // Jquery没有reset方法，取出dom对象，调用reset方法
                // 发送Ajax请求，查出部门信息显示在下拉列表中
                getDepts("#empAddModal select");
                // 打开用于新增的模态框，并设置属性，点击其他地方时此模态框不会关闭
                $("#empAddModal").modal({
                    backdrop: "static"
                })
            });

            // 查出所有的部门信息并显示在下拉列表中
            function getDepts(ele) {
                // 清空之前下拉列表的值
                $(ele).empty();
                $.ajax({
                    url: "${APP_PATH}/depts",
                    type: "GET",
                    success: function (result) {
                        // 在下拉列表中显示部门信息
                        // 遍历部门信息
                        $.each(result.extend.depts, function () {
                            var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                            optionEle.appendTo(ele);
                        });
                    }
                });
            }

            // 校验表单数据的方法
            function validate_add_form() {
                // 1.拿到需要校验的数据，使用Jquery里面的正则表达式
                var empName = $("#empName_add_input").val();
                // 允许出现a-z、A-Z、0-9、_、- ,长度为6-16位
                var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
                if (!regName.test(empName)) {
                    //alert("用户名不正确，用户名可以是6-16位英文和数字的组合或者2-5位中文");
                    // 错误信息显示
                    show_validate_msg("#empName_add_input", "error", "用户名不正确，用户名可以是6-16位英文和数字的组合或者2-5位中文");

                    return false;
                } else {

                    show_validate_msg("#empName_add_input", "success", "");
                }
                ;

                // 2.校验邮箱信息
                var email = $("#email_add_input").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if (!regEmail.test(email)) {
                    // alert("邮箱格式不正确！请重新输入！")
                    // 清空这个元素之前的样式
                    show_validate_msg("#email_add_input", "error", "邮箱格式不正确！请重新输入！");
                    // $("#email_add_input").parent().addClass("has-error");
                    // $("#email_add_input").next("span").text("邮箱格式不正确！请重新输入！");
                    return false;
                } else {
                    show_validate_msg("#email_add_input", "success", "");
                    // $("#email_add_input").parent().addClass("has-success");
                    // // 清空span中的内容
                    // $("#email_add_input").next("span").text("");
                }
                return true;
            }

            // 显示校验结果的提示信息
            function show_validate_msg(ele, status, msg) {
                // 清空当前元素的校验状态
                $(ele).parent().removeClass("has-success has-error");
                $(ele).next("span").text("");
                if ("success" == status) {
                    $(ele).parent().addClass("has-success");
                    // 清空span中的内容
                    $(ele).next("span").text(msg);
                } else if ("error" == status) {
                    $(ele).parent().addClass("has-error");
                    $(ele).next("span").text(msg);
                }
            };

            // 校验用户名是否可用
            $("#empName_add_input").change(function () {
                // 发送Ajax请求校验用户名是否可用
                var empName = this.value;
                $.ajax({
                    url: "${APP_PATH}/checkuser",
                    data: "empName=" + empName,
                    type: "POST",
                    success: function (result) {
                        if (result.code == 200) {
                            show_validate_msg("#empName_add_input", "success", "用户名可用");
                            $("#emp_save_btn").attr("ajax-va", "success");
                        } else {
                            show_validate_msg("#empName_add_input", "error", result.extend.va_msg);
                            $("#emp_save_btn").attr("ajax-va", "error");
                        }
                    }
                })
            });

            // 保存员工信息
            $("#emp_save_btn").click(function () {
                // 将模态框中提交的表单数据提交给服务器进行保存
                //1.需要给提交到服务器的数据进行校验
                if (!validate_add_form()) {
                    return false;
                }
                ;
                // 2.判断之前的Ajax校验是否成功，如校验成功，继续走下一步
                if ($(this).attr("ajax-va") == "error") {
                    return false;
                }
                // 3.发送Ajax请求保存员工
                $.ajax({
                    url: "${APP_PATH}/emp",
                    type: "POST",
                    // $("#empAddModal form").serialize() 提取要提交的数据
                    data: $("#empAddModal form").serialize(),
                    success: function (result) {
                        if (result.code == 200) {
                            // 当员工的数据保存成功以后，需要以下的步骤
                            // 1.关闭模态框
                            $("#empAddModal").modal('hide');
                            // 2.跳到最后一页，显示保存的数据
                            // 发送Ajax请求，显示最后一页数据即可
                            to_page(totalRecord);
                        } else {
                            // 如果校验失败，显示失败信息
                            // console.log(result);
                            // 有那个字段的错误信息就显示那个字段的
                            if (undefined != result.extend.errorField.email) {
                                // 显示员工的邮箱错误信息
                                show_validate_msg("#email_add_input", "error", result.extend.errorField.email);
                            }
                            if (undefined != result.extend.errorField.empName) {
                                // 显示员工的名字错误信息
                                show_validate_msg("#empName_add_input", "error", result.extend.errorField.empName);
                            }
                        }
                    }
                });
            });
            // 1.由于在创建按钮之前绑定了click事件，所以绑定不上
            // 可以在创建按钮的时候绑定事件
            $(document).on("click", ".edit_btn", function () {
                // alert(1)
                // 查出部门信息，并显示
                getDepts("#empUpdateModal select");
                // 查出员工信息，并显示
                getEmp($(this).attr("edit-id"));
                // 把员工的id传给模态框的更新按钮
                $("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
                $("#empUpdateModal").modal({
                    backdrop: "static"
                })
            });

            function getEmp(id) {
                $.ajax({
                    url: "${APP_PATH}/emp/" + id,
                    type: "GET",
                    success: function (result) {
                        // console.log(result)
                        // 员工数据
                        var empData = result.extend.emp;
                        $("#empName_update_static").text(empData.empName);
                        $("#email_update_input").val(empData.email);
                        $("#empUpdateModal input[name=gender]").val([empData.gender]);
                        $("#empUpdateModal select").val([empData.dId]);
                    }
                })
            }

            // 点击更新按钮，更新员工信息
            $("#emp_update_btn").click(function () {
                // 1.验证邮箱是否合法
                var email = $("#email_update_input").val();
                var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
                if (!regEmail.test(email)) {
                    show_validate_msg("#email_update_input", "error", "邮箱格式不正确！请重新输入！");
                    return false;
                } else {
                    show_validate_msg("#email_update_input", "success", "");
                }
                // 2.发送Ajax请求，更新保存数据
                $.ajax({
                    url: "${APP_PATH}/emp/" + $(this).attr("edit-id"),
                    type: "PUT",
                    data: $("#empUpdateModal form").serialize(),
                    success: function (result) {
                        // 1.关闭模态框
                        $("#empUpdateModal").modal("hide");
                        // 2.返回到页面
                        to_page(currentPage)
                    }

                })
            });
            // 单个删除
            $(document).on("click", ".delete_btn", function () {
                // 弹出是否删除的对话框
                var empName = $(this).parents("tr").find("td:eq(2)").text();
                // 获取需要删除员工的id
                var empId = $(this).attr("del-id");
                if (confirm("您确认要删除【" + empName + "】吗？")) {
                    // 点击确认，发送ajax请求
                    $.ajax({
                        url: "${APP_PATH}/emp/" + empId,
                        type: "DELETE",
                        success: function (result) {
                            alert(result.msg);
                            // 回到当前页
                            to_page(currentPage);
                        }
                    })
                }
            });
            // 完成多选框的全选和全不选
            // 注意： attr获取checked是underfined, 应该使用dom原生的属性prop.   attr获取自定义的属性值
            $("#check_all").click(function () {
                $(this).prop("checked");
                $(".check_item").prop("checked", $(this).prop("checked"));
            });
            // 给check_item绑定单击事件
            $(document).on("click", ".check_item", function () {
                // 判断当前选择的元素是否选满
                var flag = $(".check_item:checked").length == $(".check_item").length;
                $("#check_all").prop("checked", flag);
            });
            // 点击全部删除，就批量删除
            $("#emp_delete_all_btn").click(function () {
                var empNames = "";
                var del_idstr = "";
                // 遍历每一个被选中的元素
                $.each($(".check_item:checked"), function () {
                    // 组装员工名字和id的字符串
                    empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
                    del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
                });
                // 去除empNames 多余的逗号
                empNames = empNames.substring(0, empNames.length - 1);
                // 去除删除id时多余的“-”
                del_idstr = del_idstr.substring(0, del_idstr.length - 1);
                if (confirm("确认删除【" + empNames + "】吗？")) {
                    // 确认，发送Ajax请求
                    $.ajax({
                        url: "${APP_PATH}/emp/" + del_idstr,
                        type: "DELETE",
                        success: function (result) {
                            alert(result.msg);
                            // 回到当前页面
                            to_page(currentPage);
                        }
                    })
                }
            });
        </script>
    </body>
</html>
