<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Creator Company</title>
<link rel="stylesheet" href="/richtexteditor/rte_theme_default.css" />

<script src="https://code.jquery.com/jquery-3.6.3.min.js"></script>
<style>
</style>
</head>
<body>
	<jsp:include page="../index.jsp"/>
	<!-- Site wrapper -->
	<div class="wrapper">
		<div class="content-wrapper">
			<section class="content-header">
				<h1>새 문서 작성</h1>
			</section>
			<!-- Main content -->
			<section class="content">
				<form action="docWrite.do" method="post" enctype="multipart/form-data">
					<select id="docForm" name="docFormId" onchange="docFormListCall(this)">
						<option value="default">--</option>
						<c:forEach items="${docFormList}" var="i">
							<option value="${i.id}">${i.name}</option>
						</c:forEach>
					</select>
					<c:forEach items="${docFormList}" var="i">
						<textarea id="${i.id}" hidden="true">${i.content}</textarea>
					</c:forEach>
					<br>
					<select name="publicRange">
						<option value="all">전체</option>
						<option value="dept">부서별</option>
					</select>
					<br>
					<div id="approvalList">
					<input type="button" value="결재선 추가" onclick="addApproval()"/>
					<select name="approvalPriority">
						<option value="default">--</option>
						<c:forEach items="${approvalKindList}" var="i">
							<option value="${i.priority}">${i.name}</option>
						</c:forEach>
					</select>
					<select name="approvalMemberId">
						<option value="default">--</option>
						<c:forEach items="${memberList}" var="i">
							<option value="${i.id}">${i.dept_name} | ${i.name}</option>
						</c:forEach>
					</select>
					<br>
					</div>
					<br>
					<input type="text" name="subject" value="" placeholder="제목을 입력하세요"/>
					<br>
					<div id="div_editor">
						<!-- 에디터 안에 들어갈 자리 -->
					</div>
					<textarea hidden="true" id="content" name="content"></textarea>
					<input type="hidden" id="status" name="status"/>
					<input type="file" multiple="multiple" name="attachment"/>
					
					<input type="button" onclick="pushDoc()" value="제출"/>
					<input type="button" onclick="saveDoc()" value="임시저장"/>
				</form>
			</section>
		</div>
	</div>
</body>
<script type="text/javascript" src="/richtexteditor/rte.js"></script>  
<script type="text/javascript" src='/richtexteditor/plugins/all_plugins.js'></script>
<script>
var config = {}; // 설정
config.editorResizeMode = "none"; // 에디터 크기조절 none

var editor = new RichTextEditor("#div_editor", config);

function docFormListCall(elem){

	var docForm = document.getElementById(elem.value).value;
	editor.setHTMLCode(docForm); // editor에 내용 넣기, docForm은 기본 양식
	
}

// 결재선 추가할 때 쓸 변수 content, addApproval() 함수
var content = '';

content += '<input type="button" value="결재선 추가" onclick="addApproval()"/>';
content += '<select name="approvalPriority">';
content += '<option value="default">--</option>';
content += '<c:forEach items="${approvalKindList}" var="i">';
content += '<option value="${i.priority}">${i.name}</option>';
content += '</c:forEach>';
content += '</select>';

content += '<select name="approvalMemberId">';
content += '<option value="default">--</option>';
content += '<c:forEach items="${memberList}" var="i">';
content += '<option value="${i.id}">${i.dept_name} | ${i.name}</option>';
content += '</c:forEach>';
content += '</select>';
content += '<br>';

function addApproval(){
	
	$('#approvalList').append(content);
	
}

function pushDoc(){
	
	var submitContent = editor.getHTMLCode();
	$('textarea[name="content"]').val(submitContent);
	$('input[name="status"]').val('1');
	$('form').submit();
	
}

function saveDoc(){
	
	var submitContent = editor.getHTMLCode();
	$('textarea[name="content"]').val(submitContent);
	$('input[name="status"]').val('2');
	$('form').submit();
	
}

</script>
</html>