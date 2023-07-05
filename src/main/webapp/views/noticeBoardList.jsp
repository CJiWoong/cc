<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Projects</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
</head>
<body>
<jsp:include page = "index.jsp"></jsp:include>
<!-- Site wrapper -->
<div class="wrapper">
  <div class="content-wrapper">
    <section class="content-header">
    	<h1>공지사항</h1>         
    </section>
    <!-- Main content -->
    <section class="content">
      <table class="table table-bordered table-hover dataTable dtr-inline">
         <thead> 
            <tr> 
               <th>번호</th>
               <th>제목</th>
               <th>작성자</th>
               <th>조회수</th>
               <th>작성일</th>
               <th>삭제</th>
            </tr>
         </thead>
         <tbody>
            <c:if test="${list eq null}">
               <tr>
                  <th colspan="6">등록된 글이 없습니다.</th>
               </tr>
            </c:if>
            <c:forEach items="${list}" var="noticeBoard">
               <tr> 
                  <td>${noticeBoard.id}</td>
                  <td><a href="noticeBoardDetail.do?id=${noticeBoard.id}">${noticeBoard.subject}</a></td>
                  <td>${noticeBoard.name}</td>
                  <td>${noticeBoard.hit } </td>
                  <td>${noticeBoard.create_at }</td>
                  <td><a href="noticeBoardDel.do?id=${noticeBoard.id}">삭제</a></td>
               </tr>
            </c:forEach>
         </tbody>
      </table>
      <button class="btn btn-block btn-outline-success btn-lg" onclick="location.href='noticeBoardWrite.go'">글 작성</button>
    </section>
  </div>
</div>
<!-- ./wrapper -->
<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
</body>
<script>

	var msg = "${msg}";
	if(msg != ""){
		alert(msg);
	}

</script>
</html>