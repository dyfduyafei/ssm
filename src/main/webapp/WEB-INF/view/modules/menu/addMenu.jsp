<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/view/include/taglib.jsp" %>
<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>菜单表单</title>
    <meta name="keywords" content="keyworkdstext">
    <meta name="description" content="dericsdfsddemo">

    <%@include file="/WEB-INF/view/include/head.jsp" %>

</head>

<body class="white-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <form method="post" class="form-horizontal" id="formId">
                    <input type="hidden" name="parentId" id="parentId">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">上级菜单</label>
                        <div class="col-sm-8">
                            <input type="input" class="form-control" id="parentName" placeholder="点击选择上级菜单" readonly>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单名称</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="menuName">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">是否显示<br/>
                        </label>
                        <div class="col-sm-8">
                            <div class="radio i-checks">
                                <input type="radio" value="0" name="isShow" checked> <i></i> 是&nbsp;&nbsp;&nbsp;
                                <input type="radio" value="1" name="isShow"> <i></i> 否
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">请求地址</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="url">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">权限标识</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="permission">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单排序</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="menuSort">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">图标</label>

                        <div class="col-sm-8">
                            <input type="text" class="form-control" name="icon">
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">菜单类型</label>
                        <div class="col-sm-8">
                            <select class="form-control m-b" name="menuType">
                                <option value="M" selected>菜单</option>
                                <option value="C">目录</option>
                                <option value="B">按钮</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">启用状态<br/>
                        </label>
                        <div class="col-sm-8">
                            <div class="radio i-checks">
                                <input type="radio" value="0" name="status" checked> <i></i> 启用&nbsp;&nbsp;&nbsp;
                                <input type="radio" value="1" name="status"> <i></i> 停用
                            </div>
                        </div>
                    </div>
                    <div class="hr-line-dashed"></div>
                    <div class="form-group">
                        <div class="col-sm-4 col-sm-offset-2">
                            <button class="btn btn-primary" type="submit" id="save">保存内容</button>
                            <%--<button class="btn btn-white" type="button">取消</button>--%>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<script>
    NProgress.start();

    window.onload = function () {
        NProgress.done();
    };

    $.validator.setDefaults({
        highlight: function (e) {
            $(e).closest(".form-group").removeClass("has-success").addClass("has-error")
        }, success: function (e) {
            e.closest(".form-group").removeClass("has-error").addClass("has-success")
        }, errorElement: "span", errorPlacement: function (e, r) {
            e.appendTo(r.is(":radio") || r.is(":checkbox") ? r.parent().parent().parent() : r.parent())
        }, errorClass: "help-block m-b-none", validClass: "help-block m-b-none"
    });

    $(function () {
        $('#parentName').focus(function () {
            $.modal.open('选择菜单', '${ctx}/modules/menu/toMenuTree', '250px', '500px');
        });

        var e = "<i class='fa fa-times-circle'></i> ";
        $("#formId").validate({
            rules: {
                menuName: {required: true, minlength: 2},
                <%--userName: {required: true, minlength: 2, remote: "${ctx}/user/checkMenuName"},--%>
                url: {required: true},
                menuSort: {required: true}
            },
            messages: {
                menuName: {required: e + "请输入菜单名字", minlength: e + "用户名必须两个字符以上"},
                url: {required: e + "请输入url"},
                menuSort: {required: e + "请输入菜单排序"}
            },
            submitHandler: function (form) {
                $.operator.save("${ctx}/modules/menu/save");
            }
        });
    });
</script>

</body>

</html>