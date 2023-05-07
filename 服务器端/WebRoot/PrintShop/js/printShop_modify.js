$(function () {
	$.ajax({
		url : "PrintShop/" + $("#printShop_shopUserName_edit").val() + "/update",
		type : "get",
		data : {
			//shopUserName : $("#printShop_shopUserName_edit").val(),
		},
		beforeSend : function () {
			$.messager.progress({
				text : "正在获取中...",
			});
		},
		success : function (printShop, response, status) {
			$.messager.progress("close");
			if (printShop) { 
				$("#printShop_shopUserName_edit").val(printShop.shopUserName);
				$("#printShop_shopUserName_edit").validatebox({
					required : true,
					missingMessage : "请输入餐饮店账号",
					editable: false
				});
				$("#printShop_password_edit").val(printShop.password);
				$("#printShop_password_edit").validatebox({
					required : true,
					missingMessage : "请输入登录密码",
				});
				$("#printShop_shopName_edit").val(printShop.shopName);
				$("#printShop_shopName_edit").validatebox({
					required : true,
					missingMessage : "请输入餐饮店名称",
				});
				$("#printShop_shopPhoto").val(printShop.shopPhoto);
				$("#printShop_shopPhotoImg").attr("src", printShop.shopPhoto);
				$("#printShop_shopDesc_edit").val(printShop.shopDesc);
				$("#printShop_shopDesc_edit").validatebox({
					required : true,
					missingMessage : "请输入餐饮店介绍",
				});
				$("#printShop_bornDate_edit").datebox({
					value: printShop.bornDate,
					required: true,
					showSeconds: true,
				});
				$("#printShop_connectPerson_edit").val(printShop.connectPerson);
				$("#printShop_connectPerson_edit").validatebox({
					required : true,
					missingMessage : "请输入联系人",
				});
				$("#printShop_telephone_edit").val(printShop.telephone);
				$("#printShop_telephone_edit").validatebox({
					required : true,
					missingMessage : "请输入联系电话",
				});
				$("#printShop_address_edit").val(printShop.address);
			} else {
				$.messager.alert("获取失败！", "未知错误导致失败，请重试！", "warning");
				$(".messager-window").css("z-index",10000);
			}
		}
	});

	$("#printShopModifyButton").click(function(){ 
		if ($("#printShopEditForm").form("validate")) {
			$("#printShopEditForm").form({
			    url:"PrintShop/" +  $("#printShop_shopUserName_edit").val() + "/update",
			    onSubmit: function(){
					if($("#printShopEditForm").form("validate"))  {
	                	$.messager.progress({
							text : "正在提交数据中...",
						});
	                	return true;
	                } else {
	                    return false;
	                }
			    },
			    success:function(data){
			    	$.messager.progress("close");
                	var obj = jQuery.parseJSON(data);
                    if(obj.success){
                        $.messager.alert("消息","信息修改成功！");
                        $(".messager-window").css("z-index",10000);
                        //location.href="frontlist";
                    }else{
                        $.messager.alert("消息",obj.message);
                        $(".messager-window").css("z-index",10000);
                    } 
			    }
			});
			//提交表单
			$("#printShopEditForm").submit();
		} else {
			$.messager.alert("错误提示","你输入的信息还有错误！","warning");
			$(".messager-window").css("z-index",10000);
		}
	});
});
