<%@ page language="java"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/> 
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/printShop.css" /> 

<div id="printShop_manage"></div>
<div id="printShop_manage_tool" style="padding:5px;">
	<div style="margin-bottom:5px;">
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit-new" plain="true" onclick="printShop_manage_tool.edit();">修改</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-delete-new" plain="true" onclick="printShop_manage_tool.remove();">删除</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-reload" plain="true"  onclick="printShop_manage_tool.reload();">刷新</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-redo" plain="true" onclick="printShop_manage_tool.redo();">取消选择</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-export" plain="true" onclick="printShop_manage_tool.exportExcel();">导出到excel</a>
	</div>
	<div style="padding:0 0 0 7px;color:#333;">
		<form id="printShopQueryForm" method="post">
			餐饮店账号：<input type="text" class="textbox" id="shopUserName" name="shopUserName" style="width:110px" />
			餐饮店名称：<input type="text" class="textbox" id="shopName" name="shopName" style="width:110px" />
			成立日期：<input type="text" id="bornDate" name="bornDate" class="easyui-datebox" editable="false" style="width:100px">
			联系人：<input type="text" class="textbox" id="connectPerson" name="connectPerson" style="width:110px" />
			联系电话：<input type="text" class="textbox" id="telephone" name="telephone" style="width:110px" />
			<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="printShop_manage_tool.search();">查询</a>
		</form>	
	</div>
</div>

<div id="printShopEditDiv">
	<form id="printShopEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">餐饮店账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_shopUserName_edit" name="printShop.shopUserName" style="width:200px" />
			</span>
		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_password_edit" name="printShop.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">餐饮店名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_shopName_edit" name="printShop.shopName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">餐饮店照片:</span>
			<span class="inputControl">
				<img id="printShop_shopPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="printShop_shopPhoto" name="printShop.shopPhoto"/>
				<input id="shopPhotoFile" name="shopPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">餐饮店介绍:</span>
			<span class="inputControl">
				<textarea id="printShop_shopDesc_edit" name="printShop.shopDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_bornDate_edit" name="printShop.bornDate" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_connectPerson_edit" name="printShop.connectPerson" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_telephone_edit" name="printShop.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">餐饮店地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_address_edit" name="printShop.address" style="width:200px" />

			</span>

		</div>
	</form>
</div>
<script type="text/javascript" src="PrintShop/js/printShop_manage.js"></script> 
