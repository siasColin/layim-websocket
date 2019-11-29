<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<title>KingIM</title>
<head>
<meta charset="utf-8">
<link rel="stylesheet" href="/css/reset.css">
<link rel="stylesheet" type="text/css" href="/layim/css/layui.css" media="all"/>
<link rel="stylesheet" href="/css/friend.css">
</head>
<body>
<div class="main">
    <div class="layui-row" style="height:100%;">
        <div class="layui-col-sm10 layui-col-sm-offset1" style="height:100%;background: #fff;">
            <div class="layui-col-sm3" style="height:100%;">
                <ul class="Grouping">
                <c:forEach items="${mineFriendTypeList}" var="mineFriendType" >
                    <li data-id="${mineFriendType.id}">
                        <span>${mineFriendType.type_name}</span>
                        <i>${mineFriendType.total}</i>
                    </li>
                </c:forEach>
                </ul>
                <button class="addgroup layui-btn layui-btn-primary" type="button" onclick="addFriendType();">添加分组</button>
            </div>
            <div class="layui-col-sm9" style="height:100%;overflow: auto;">
                <ul class="FriendDetails">

                </ul>
            </div>
        </div>
    </div>

</div>
<script src="/js/jquery.min.js"></script>
<script src="/layim/layui.all.js"></script>
<script>
    document.onselectstart = function () { return false; };

    layui.use(['form'], function () {
        var form = layui.form;
    });
    $('.Grouping').find('li').on('click', function () {
        $(this).addClass('li_active').siblings().removeClass('li_active');
        //加载分组下好友
        $.ajax({
//            async:false,
            type: "POST",
            url: '/friend/getFriendByTypeId',
            data:{"typeId":$(this).attr("data-id"),userId:$("#userId",window.parent.document).val()},
            dataType: "json",
            success: function(res){
                if(res.code != 0){
                    return layui.layer.msg(res.msg);
                }
                setFriend(res.data);
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    })
    function setFriend(data) {
        var friendhtml = '';
        for(var i = 0;i < data.length; i++) {
            var typeSelectHtml = '<select name="city" lay-verify="" lay-filter="test" id="typeselect'+data[i].id+'">';
            $('.Grouping').find('li').each(function() {
                if($(this).index() != 0){
                    typeSelectHtml += '<option value="'+$(this).attr("data-id")+'"';
                            if($(this).attr("data-id") == data[i].type_id){
                                typeSelectHtml += 'selected=selected';
                            }
                    typeSelectHtml += '>'+$(this).find("span").text()+'</option>';
                }
            })
            typeSelectHtml+='</select>';
            friendhtml += '<li><div class="HeadPortrait"><img src="'+data[i].avatar+'" alt="">' +
                '</div><div class="FriendInformation"><p class="name">'+data[i].nick_name+
                '</p><p>备注：<i ondblclick="toReplace(this)">'+data[i].remark+
                '</i></p><div class="SetGrouping"><div class="layui-input-inline layui-form">' +
                typeSelectHtml +
                '</div> <button type="button" class="layui-btn layui-btn-normal layui-btn-radius layui-btn-xs">移动至</button>' +
                '</div><button class="layui-btn layui-btn-primary layui-btn-xs">删除</button></div></li>';
        }
        $(".FriendDetails").html(friendhtml);
        layui.form.render('select');
    }
    $(".Grouping li").first().click();
    function toReplace(divElement) {
        var inputElement = document.createElement("input");
        inputElement.id = 'replaceinput'
        var txt = divElement.innerHTML
        inputElement.value = divElement.innerHTML;
        divElement.parentNode.replaceChild(inputElement, divElement);
        inputElement.focus()
        inputElement.onblur = function () {
            divElement.innerHTML = inputElement.value;
            inputElement.parentNode.replaceChild(divElement, inputElement);
            if(inputElement.value == ''){
                divElement.innerHTML = txt
            }
            if(inputElement.value != ''){
                $(divElement).parent().siblings('.name').text(inputElement.value)
            }

        }
    }
    function addFriendType(){
        layui.layer.open({
            title:"添加群组",
            type: 2,
            area: ['450px','300px'],
            btn: ['保存', '取消'],
            content: '/friend/addFriendTypePage?userId='+$("#userId",window.parent.document).val(),
            yes: function(index,layero){
                // 获取iframe层的body
                var body = layer.getChildFrame('body', index);
                // 找到隐藏的提交按钮模拟点击提交
                body.find('#permissionSubmit').click();
            }
        });
    }
</script>
</body>
</html>

