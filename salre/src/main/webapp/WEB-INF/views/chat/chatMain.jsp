<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.servletContext.contextPath}"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no, maximum-scale=1, shrink-to-fit=no, viewport-fit=cover">
<meta name="color-scheme" content="light dark">

<title>살래?! 채팅</title>

<!-- Favicon -->
<link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">

<!-- Font -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700" rel="stylesheet">

<!-- Template CSS -->
<link class="css-lt" rel="stylesheet" href="${contextPath}/resources/bootstrap/chat/assets/css/template.bundle.css" media="(prefers-color-scheme: light)">
<link class="css-dk" rel="stylesheet" href="${contextPath}/resources/bootstrap/chat/assets/css/template.dark.bundle.css" media="(prefers-color-scheme: dark)">

<!-- Theme mode -->
<script>
    if (localStorage.getItem('color-scheme')) {
        let scheme = localStorage.getItem('color-scheme');

        const LTCSS = document.querySelectorAll('link[class=css-lt]');
        const DKCSS = document.querySelectorAll('link[class=css-dk]');

        [...LTCSS].forEach((link) => {
            link.media = (scheme === 'light') ? 'all' : 'not all';
        });

        [...DKCSS].forEach((link) => {
            link.media = (scheme === 'dark') ? 'all' : 'not all';
        });
    }
</script>

<!-- jQuery -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<!-- Layout -->
	<div class="layout overflow-hidden">
	    <!-- Sidebar -->
	    <aside class="sidebar bg-light">
	        <div class="tab-content h-100" role="tablist">
	            <!-- Chats -->
	            <div class="tab-pane fade h-100 show active" id="tab-content-chats" role="tabpanel">
	                <div class="d-flex flex-column h-100 position-relative">
	                    <div class="hide-scrollbar">
	
	                        <div class="container py-8">
	                            <!-- Title -->
	                            <div class="mb-8">
	                                <h2 class="fw-bold m-0">Chats</h2>
	                            </div>
	
	                            <!-- Search -->
	                            <div class="mb-6">
	                                <form action="#">
	                                    <div class="input-group">
	                                        <div class="input-group-text">
	                                            <div class="icon icon-lg">
	                                                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>
	                                            </div>
	                                        </div>
	
	                                        <input type="text" class="form-control form-control-lg ps-0" placeholder="Search messages or users" aria-label="Search for messages or users...">
	                                    </div>
	                                </form>
	                            </div>
	
	                            <!-- Chats -->
	                            <div class="card-list">
	                                <!-- Card -->
	                                <a href="javascript:enterChatRoom();" class="card border-0 text-reset">
	                                    <div class="card-body">
	                                        <div class="row gx-5">
	                                            <div class="col-auto">
	                                                <div class="avatar avatar-online">
	                                                    <img src="${contextPath}/resources/bootstrap/chat/assets/img/avatars/6.jpg" alt="#" class="avatar-img">
	                                                </div>
	                                            </div>
	
	                                            <div class="col">
	                                                <div class="d-flex align-items-center mb-3">
	                                                    <h5 class="me-auto mb-0">Ollie Chandler</h5>
	                                                    <span class="text-muted extra-small ms-2">08:45 PM</span>
	                                                </div>
	
	                                                <div class="d-flex align-items-center">
	                                                    <div class="line-clamp me-auto">
	                                                        Hello! Yeah, I'm going to meet friend of mine at the departments stores now.
	                                                    </div>
	
	                                                    <div class="badge badge-circle bg-primary ms-5">
	                                                        <span>3</span>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div><!-- .card-body -->
	                                </a>
	                                <!-- Card -->
	
	                                <!-- Card -->
	                                <a href="chat-empty.html" class="card border-0 text-reset">
	                                    <div class="card-body">
	                                        <div class="row gx-5">
	                                            <div class="col-auto">
	                                                <div class="avatar avatar-online">
	                                                    <img src="${contextPath}/resources/bootstrap/chat/assets/img/avatars/8.jpg" alt="#" class="avatar-img">
	                                                </div>
	                                            </div>
	
	                                            <div class="col">
	                                                <div class="d-flex align-items-center mb-3">
	                                                    <h5 class="me-auto mb-0">Elise Dennis</h5>
	                                                    <span class="text-muted extra-small ms-2">08:35 PM</span>
	                                                </div>
	
	                                                <div class="d-flex align-items-center">
	                                                    <div class="line-clamp me-auto">
	                                                        is typing<span class='typing-dots'><span>.</span><span>.</span><span>.</span></span>
	                                                    </div>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div><!-- .card-body -->
	                                </a>
	                                <!-- Card -->
	
	                                <!-- Card -->
	                                <a href="chat-direct.html" class="card border-0 text-reset">
	                                    <div class="card-body">
	                                        <div class="row gx-5">
	                                            <div class="col-auto">
	                                                <div class="avatar">
	                                                    <svg class="avatar-img placeholder-img" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder" preserveAspectRatio="xMidYMid slice" focusable="false">
	                                                        <title>Placeholder</title>
	                                                        <rect width="100%" height="100%" fill="#868e96"></rect>
	                                                    </svg>
	                                                </div>
	                                            </div>
	
	                                            <div class="col">
	                                                <div class="d-flex align-items-center mb-3">
	                                                    <h5 class="placeholder-glow  w-100  mb-0">
	                                                        <span class="placeholder col-5"></span>
	                                                    </h5>
	                                                </div>
	
	                                                <div class="placeholder-glow">
	                                                    <span class="placeholder col-12"></span>
	                                                    <span class="placeholder col-8"></span>
	                                                </div>
	                                            </div>
	                                        </div>
	                                    </div><!-- .card-body -->
	                                </a>
	                                <!-- Card -->
	                            </div>
	                            <!-- Chats -->
	                        </div>
	
	                    </div>
	                </div>
	            </div>
	        </div>
	    </aside>
	    <!-- Sidebar -->
	
	    <!-- Chat -->
	    <main class="main">
	        <div class="container h-100" id="chatRoomArea">
	
	            <div class="d-flex flex-column h-100 justify-content-center text-center">
	                <div class="mb-6">
	                    <span class="icon icon-xl text-muted">
	                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-message-square"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>
	                    </span>
	                </div>
	
	                <p class="text-muted">Pick a person from left menu, <br> and start your conversation.</p>
	            </div>
	
	        </div>
	    </main>
	    <!-- Chat -->
	
	</div>
	<!-- Layout -->
	
	<!-- Scripts -->
	<script src="${contextPath}/resources/bootstrap/chat/assets/js/vendor.js"></script>
	<script src="${contextPath}/resources/bootstrap/chat/assets/js/template.js"></script>
	
	<!-- 채팅방 입장 -->
	<script type="text/javascript">
		function enterChatRoom() {
			let user_id = 1;
			
			$.ajax({
				url: "${contextPath}/chat/enterChatRoom",
				type: "GET",
				data: { user_id: user_id },
				success: function(res) {
					$("#chatRoomArea").html(res);
				},
				error: function(err) {
					alert(err);
				}
			});
		}
	</script>
</body>
</html>