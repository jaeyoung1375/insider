<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<h2>다중파일업로드</h2>

<div class="container">
    <div class="row">
        <aside class="col">
            <h1>인사이더</h1>
        </aside>
        <article class="col">
            <div class="row">
                <div class="col">
                    <h1>파일 업로드</h1>
                </div>
            </div>
            <div class="row">
                <div class="col">
					<!-- 이름을 -->
                    <form action="upload" method="post" enctype="multipart/form-data">
                        <input type="file" name="attach" max-size="100000000">
                        <br><br>
                        <button>업로드</button>
                    </form>
                </div>
            </div>            
        </article>
    </div>
</div>