<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<link rel="stylesheet" href="/css/common.css">
	<link rel="stylesheet" href="/css/product/list.css">

<title>Insert title here</title>
</head>
<body>
	<div id="wrapper">
		<c:import url="/WEB-INF/views/navbar/navbar.jsp"></c:import>
		<c:import url="/WEB-INF/views/navbar/sideBar.jsp"></c:import>
		<div id="container">
			
			<div id="contents">
				
				<c:choose>
					<c:when test="${not empty cateCd.product_categoryCode}">	
					
						<c:choose>
							<c:when test="${cateCd.product_categoryCode eq 001}"><h2>COFFEE</h2></c:when>
							<c:when test="${cateCd.product_categoryCode eq 002}"><h2>MACHINES</h2></c:when>
							<c:when test="${cateCd.product_categoryCode eq 003}"><h2>COFFEE</h2></c:when>
							<c:when test="${cateCd.product_categoryCode eq 004}"><h2>COFFEE</h2></c:when>
						</c:choose>
					
						<c:forEach var="categoryCnt" items="${categoryCnt}">
							<c:if test="${cateCd.product_categoryCode eq categoryCnt.code}">
								<h2>${categoryCnt.name}</h2>
							</c:if>
						</c:forEach>
						
						<img class="listMainImg" alt="" src="/images/product/list/productList_${cateCd.product_categoryCode}.jpg">
										
						<div class="productCategory">
							<c:forEach var="categoryCnt" items="${categoryCnt}">
								<a href="/product/list?product_categoryCode=${categoryCnt.code}">${categoryCnt.name} <span>(${categoryCnt.count})</span></a>
							</c:forEach>
						</div>
						
					</c:when>
					<c:otherwise>
						<h2>ALL PRODUCT</h2>
						<img class="mainImg" alt="" src="/images/product/list/ALL_PRODUCT.jpg">
					</c:otherwise>
				</c:choose>
				
				<div class="productPickList">
					<span class="pickListNum">상품 <strong>${listAllProduct.size()}</strong> 개</span>
					<ul class="pickListBox">
						<li>
							<input type="radio" id="sort1" name="sort" checked="checked">
							<label for="sort1" class="sortLabel on">낮은가격순</label>
						</li>
						<li>
							<input type="radio" id="sort2" name="sort">
							<label for="sort2" class="sortLabel">높은가격순</label>
						</li>
						<li>
							<input type="radio" id="sort3" name="sort">
							<label for="sort3" class="sortLabel">상품평순</label>
						</li>
						<li>
							<input type="radio" id="sort4" name="sort">
							<label for="sort4" class="sortLabel">등록일순</label>
						</li>
					</ul>
				</div>
				
				<ul class="productList">
				<c:forEach var="productVO" items="${listAllProduct}">
					<li>
						<div class="productWrap">
							<a href="/product/select?product_categoryCode=${productVO.product_categoryCode}&product_id=${productVO.product_id}">
								<div class="productImgWrap">
									<img alt="" src="/upload/product/${productVO.productFileVOs[0].productFile_name}">
								</div>
								<span class="productName">${productVO.product_name}</span>
							</a>
							<div class="iconBox"></div>
							<span class="productPrice pricePattern">${productVO.product_price}</span>
							<button class="btnDefault red insertCart" data-product-id="${productVO.product_id}">장바구니</button>
							<button class="btnDefault red directPayment" data-product-id="${productVO.product_id}">구매하기</button>
						</div>
					</li>
				</c:forEach>
				</ul>
				
				<div class="pagination">
					<ul>
						<li><span>1</span></li>
					<c:forEach begin="0" end="3" varStatus="i">
						<li><a href="javascript:;">${i.count+1}</a></li>
					</c:forEach>
					</ul>
				</div>
				
			</div>
			
		</div>
		<c:import url="/WEB-INF/views/navbar/footer.jsp"></c:import>
	</div>
</body>
	<script type="text/javascript">
	
		$().ready(function(){
			$('.pricePattern').each(function(){
				$(this).html(Number($(this).html()).toLocaleString() + '원');
			})
		});
	
		$('input[type=radio]').change(function(){
			$('.sortLabel').each(function(){ $(this).removeClass('on')})
			$(this).next().addClass('on');
		}); /********** 상품 기준별 재정렬 **********/
		
		$('.productWrap').hover(function(){
			$(this).find('button').fadeIn( "fast" );
		}, function(){
			$(this).find('button').css('display', 'none');
		});
		
		
		/* ijy - 상품 바로구매하기 */
		$('.directPayment').click(function(){
			console.log('product_id: '+$(this).attr('data-product-id'));
			
			location.href="/payment/directPayment?cart_cnt=1&product_id="+$(this).attr('data-product-id');
		});
		
		//장바구니 담기
		$('.insertCart').click(function(){
			console.log('product_id: '+$(this).attr('data-product-id'));
			
			$.ajax({
				type:"GET",
				url:"/cart/setCart",
				data: {
					product_id: $(this).attr('data-product-id'),
					cart_cnt: 1
				},
				success: function(result) {
					alert(result); //모달창 띄워서 장바구니로 가냐 마냐
				},
				error : function(xhr, status, error){
					console.log(error);				
				}
			
			});
		});
	</script>
</html>