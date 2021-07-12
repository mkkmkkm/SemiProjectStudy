<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>High-clear</title>
<link rel="icon" href="${pageContext.request.contextPath}/images/shuttlecock_main.png" type="image/x-icon" />
<link href="<%=request.getContextPath() %>/cafe/form.css" rel="stylesheet">
<style>
	body{
      height: 100vh;
      background-image: url("images/badminton_illust_up.png"); /*2가지 이미 images/badmintonillust1.png*/
      background-repeat: no-repeat;
      background-position: center;
      background-size: cover;
   }
   .modal {
   	  left: 0 !important;
      top: 0 !important;	
   	  z-index: 0;
   	  position: fixed !important;
   	  height: 100% !important;
   	  width: 100% !important;
   	  }
    .modal-content {
    	position: center !important;
     	margin: 10% auto !important;
    	width: 21% !important;
    	}
</style>
</head>
<body>
<jsp:include page="include/navbar.jsp"></jsp:include>

<script src="https://code.jquery.com/jquery-latest.js"></script> 

    <!-- The Modal -->
    <div id="myModal" class="modal">
 
      <!-- Modal content -->
      <div class="modal-content">
      <p style="text-align: center;"><span style="font-size: 14pt;"><b><span style="color: green; font-size: 24pt;">*JOIN US~~*</span></b></span></p>
      <a href="http://www.badmintonmart.com/shop/main/index.php"> <img src="<%=request.getContextPath() %>/images/notice.jpg" class="card-img-top" height=300px width=240px; />
                </a>
    <div style="cursor:pointer;background-color:black; color:white; text-align: center;padding-bottom: 10px;padding-top: 10px;" onClick="close_pop();">
                <span class="pop_bt" style="font-size: 13pt;" >
                     3초후 자동으로 사라집니다^^
                </span>
            </div>
      </div>
 
    </div>
        <!--End Modal-->
 
 
    <script type="text/javascript">
      
        jQuery(document).ready(function() {
                $('#myModal').show();
        });
        //팝업 Close 기능
        function close_pop(flag) {
             $('#myModal').hide();
             
        };
        //3초후 자동으로 사라지기 
        setTimeout(function() { $('#myModal').hide();}, 3000)
      </script>



</body>

</html>