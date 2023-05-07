<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/product.css" />
<div id="product_editDiv">
	<form id="productEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">商品id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productId_edit" name="product.productId" value="<%=request.getParameter("productId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">菜品类别:</span>
			<span class="inputControl">
				<input class="textbox"  id="product_productClassObj_classId_edit" name="product.productClassObj.classId" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">菜品名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_productName_edit" name="product.productName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">菜品图片:</span>
			<span class="inputControl">
				<img id="product_mainPhotoImg" width="200px" border="0px"/><br/>
    			<input type="hidden" id="product_mainPhoto" name="product.mainPhoto"/>
				<input id="mainPhotoFile" name="mainPhotoFile" type="file" size="50" />
			</span>
		</div>
		<div>
			<span class="label">套餐价格:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_price_edit" name="product.price" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">菜品描述:</span>
			<span class="inputControl">
				<textarea id="product_productDesc_edit" name="product.productDesc" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">餐饮店:</span>
			<span class="inputControl">
				<input class="textbox"  id="product_printShopObj_shopUserName_edit" name="product.printShopObj.shopUserName" style="width: auto"/>
			</span>
		</div>
		<div>
			<span class="label">发布时间:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="product_addTime_edit" name="product.addTime" />

			</span>

		</div>
		<div class="operation">
			<a id="productModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/Product/js/product_modify.js"></script> 
