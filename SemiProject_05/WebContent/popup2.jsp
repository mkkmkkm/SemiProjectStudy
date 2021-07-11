<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modal</title>
    <style>
        #modal.modal-overlay {
            width: 380px;
            height: 380px;
            /*position: absolute;*/
            left: 0;
            top: 0;
            margin: 10px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            box-shadow: 0 8px 30px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: blur(1.5px);
            -webkit-backdrop-filter: blur(1.5px);
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.18);
        }
        #modal .modal-window {
            background: #ffffff;
            box-shadow: 0 8px 20px 0 rgba( 31, 38, 135, 0.37 );
            backdrop-filter: blur( 13.5px );
            -webkit-backdrop-filter: blur( 13.5px );
            border-radius: 10px;
            border: 1px solid rgba( 255, 255, 255, 0.18 );
            width: 380px;
            height: 380px;
            position: relative;
            top: 0px;
            padding: 0px;
        }
        #modal .title {
            padding-left: 50px;
            /*display: inline;*/
            text-shadow: 1px 1px 2px gray;
            color: #066D19;
         
        }
        /*#modal .title h2 {
            display: inline;
        }*/
        
        #modal .close-area {
            display: inline;
            float: right;
            padding-right: 10px;
            cursor: pointer;
            text-shadow: 1px 1px 2px gray;
            color: green;
        }
        
        #modal .content {
            margin-top: 10px;
            padding: 0px 0px;
            /* text-shadow: 1px 1px 2px gray; */
            color: white;
        }
    </style>
</head>
<body>
    <div id="container">
        <div id="lorem-ipsum"></div>
    </div>
    <div id="modal" class="modal-overlay">
        <div class="modal-window">
            <div class="title">
                <h3>배드민턴 용품 여름 세일</h3>
            </div>
            <div class="close-area">X</div>
            <div class="content">
                <p class="card-text">
    	<a href="http://www.badmintonmart.com/shop/main/index.php"> <img src="<%=request.getContextPath() %>/images/201910016226_500.jpg" class="card-img-top" alt="..." height=280px width=260px; />
		</a>
    </p>      
        </div>
        </div>
    </div>
    <script>
    const loremIpsum = document.getElementById("lorem-ipsum")
    fetch("index.jsp")
        .then(response => response.text())
        .then(result => loremIpsum.innerHTML = result)
	const closeBtn = modal.querySelector(".close-area")
	closeBtn.addEventListener("click", e => {
    modal.style.display = "none"
})
    </script>
</body>
</html>