<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/printShop.css" />
<div id="printShopAddDiv">
	<form id="printShopAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">餐饮店账号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_shopUserName" name="printShop.shopUserName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">登录密码:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_password" name="printShop.password" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">餐饮店名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_shopName" name="printShop.shopName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">餐饮店照片:</span>
			<span class="inputControl">
				<input id="shopPhotoFile" name="shopPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">餐饮店介绍:</span>
			<span class="inputControl">
				<textarea id="printShop_shopDesc" name="printShop.shopDesc" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_bornDate" name="printShop.bornDate" />

			</span>

		</div>
		<div>
			<span class="label">联系人:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_connectPerson" name="printShop.connectPerson" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">联系电话:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_telephone" name="printShop.telephone" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">餐饮店地址:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="printShop_address" name="printShop.address" style="width:200px" />

			</span>

		</div>
		<div class="operation">
			<a id="printShopAddButton" class="easyui-linkbutton">添加</a>
			<a id="printShopClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/PrintShop/js/printShop_add.js"></script> 
