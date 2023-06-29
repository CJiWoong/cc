<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>AdminLTE 3 | Compose Message</title>

  <!-- Google Font: Source Sans Pro -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,400i,700&display=fallback">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="../../plugins/fontawesome-free/css/all.min.css">
  <!-- Theme style -->
  <link rel="stylesheet" href="../../dist/css/adminlte.min.css">
  <!-- summernote -->
  <link rel="stylesheet" href="../../plugins/summernote/summernote-bs4.min.css">
</head>
<body class="hold-transition sidebar-mini">
<jsp:include page = "index.jsp"></jsp:include>
<div class="wrapper">
  <!-- Navbar -->
  

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Compose</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Compose</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>
<form action="msWrite.do" method="post" enctype="multipart/form-data">
    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
 
          <div class="col-md-9">
            <div class="card card-primary card-outline">
              <div class="card-header">
                <h3 class="card-title">Compose New Message</h3>
              </div>
              <!-- /.card-header -->
              <div class="card-body">
                <div class="form-group">
                <input type="text" name="from_id" value="${loginId}" readonly="readonly" hidden="true" required/>
                <input type="text" class="form-control" name="to_id" placeholder="받는 사람: " />
                <!-- <button onclick="location.href='msMemberList.go'">주소록</button> -->
              	<a data-toggle="modal" data-target="#modal" role="button">lock</a>   
                	                        
                </div>
				<div id="modal" class="modal fade" tabindex="-1" role="dialog">
				    <div class="modal-dialog">
				        <div class="modal-content">
				        </div>
				    </div>
				</div>
			
			
                <div class="form-group">
                  <input class="form-control" name="title" maxlength="19" onkeyup="counter(event, '20')" placeholder="제목을 입력하세요">
                  <span id="reCount">0 / 20</span>
                </div>
                <div class="form-group" name="content">
                    <textarea id="compose-textarea" class="form-control" style="height: 300px" name="content">
                      
                    </textarea>
                </div>
                
			<div class="form-group">
			  <div class="btn btn-default btn-file">
			    <i class="fas fa-paperclip"></i> 파일 첨부
			    <input type="file" name="file" multiple="multiple" onchange="displayFileNames(event)" id="fileInput">
			  </div>
			  <p class="help-block">Max. 32MB</p>
			  <div id="fileNames"></div>
			</div>


              <!-- /.card-body -->
              <div class="card-footer">
                <div class="float-right">
                  <button type="button" class="btn btn-default"><i class="fas fa-pencil-alt"></i> Draft</button>
                  <button type="submit" class="btn btn-primary"><i class="far fa-envelope"></i> Send</button>
                </div>
                <button type="reset" class="btn btn-default"><i class="fas fa-times"></i> Discard</button>
              </div>
              <!-- /.card-footer -->
            </div>
            <!-- /.card -->
          </div>
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div><!-- /.container-fluid -->
      </div>
    </section>
    <!-- /.content -->
  </form>
  </div>
  <!-- /.content-wrapper -->
  <footer class="main-footer">
    <div class="float-right d-none d-sm-block">
      <b>Version</b> 3.2.0
    </div>
    <strong>Copyright &copy; 2014-2021 <a href="https://adminlte.io">AdminLTE.io</a>.</strong> All rights reserved.
  </footer>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
  </aside>
  <!-- /.control-sidebar -->
</div>
<!-- ./wrapper -->

<!-- jQuery -->
<script src="../../plugins/jquery/jquery.min.js"></script>
<!-- Bootstrap 4 -->
<script src="../../plugins/bootstrap/js/bootstrap.bundle.min.js"></script>
<!-- AdminLTE App -->
<script src="../../dist/js/adminlte.min.js"></script>
<!-- Summernote -->
<script src="../../plugins/summernote/summernote-bs4.min.js"></script>
<!-- AdminLTE for demo purposes -->
<script src="../../dist/js/demo.js"></script>
<!-- Page specific script -->
<script>
  $(function () {
    //Add text editor
    $('#compose-textarea').summernote()
  })
  
	$(".modal-content").load("/msMemberList.go");
  
  function counter(event, limit){
	    var val = event.target.value.length;
	    var elem = $(event.target).siblings().find('span');
	    console.log(val);
	    console.log(limit);
	    console.log(elem);
	    if(val <= limit){
	      elem.html(val + " / " + limit);
	      if (val >= 17) {
	        elem.css('color', 'red');
	      } else {
	        elem.css('color', ''); // 기본 색상으로 변경 (CSS 스타일 제거)
	      }
	    }
	  }
	  
	  // 글자 수 실시간 업데이트
	  var titleInput = document.querySelector('input[name="title"]');
	  var countSpan = document.getElementById('reCount');
	  
	  titleInput.addEventListener('input', function() {
	    var count = this.value.length;
	    countSpan.innerText = count + ' / 20';
	    
	    if (count >= 20) {
	      countSpan.style.color = 'red';
	    } else {
	      countSpan.style.color = ''; // 기본 색상으로 변경 (CSS 스타일 제거)
	    }
	  });

	  function displayFileNames(event) {
		    var fileNamesDiv = document.getElementById('fileNames');
		    fileNamesDiv.innerHTML = '';
		    
		    var files = Array.from(event.target.files);
		    files.forEach(function(file) {
		      var fileNameSpan = document.createElement('span');
		      fileNameSpan.innerText = file.name;

		      var cancelIcon = document.createElement('i');
		      cancelIcon.className = 'fas fa-times cancel-icon';
		      cancelIcon.addEventListener('click', function() {
		        removeFile(file, fileNameSpan);
		      });

		      var fileNameContainer = document.createElement('div');
		      fileNameContainer.className = 'file-name-container';
		      fileNameContainer.appendChild(fileNameSpan);
		      fileNameContainer.appendChild(cancelIcon);

		      fileNamesDiv.appendChild(fileNameContainer);
		    });
		  }

		  function removeFile(file, fileNameSpan) {
		    var fileInput = document.getElementById('fileInput');
		    fileInput.value = '';

		    fileNameSpan.parentNode.remove();
		  }


</script>

</body>
</html>
