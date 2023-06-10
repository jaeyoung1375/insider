<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../template/header.jsp"%>
 <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f5f5f5;
            text-align: center;
        }

        .container {
            max-width: 400px;
            margin: 100px auto;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        h1 {
            color: #333;
        }

        p {
            color: #777;
            margin-bottom: 20px;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }

        .btn:hover {
            background-color: #0056b3;
        }
    </style>
 <div class="container">
        <h1>이메일 동의 오류</h1>
        <p>회원 가입을 위해서는 요구하는 개인정보 수집에 동의해주셔야 합니다!</p>
        <a href="/member/login" class="btn">로그인 페이지로 이동</a>
    </div>


<%@ include file="../template/footer.jsp"%>