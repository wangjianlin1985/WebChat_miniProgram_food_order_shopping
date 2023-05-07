<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/printShop.css" />
<div id="printShop_editDiv">
	<form id="printShopEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">餐饮店账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_shopUserName_edit" name="printShop.shopUserName" value="<%=request.getParameter("shopUserName") %>" style="width:200px" />
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
		<div class="operation">
			<a id="printShopModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/PrintShop/js/printShop_modify.js"></script> 
