<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@page import="database.Database" %>
<%@page import="util.QuestionAnswer" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>BuyMe</title>
    <link rel="stylesheet" href="css/main.css">
</head>

<body>
<%@ include file="navigationBar.jsp" %>
<% if ((session.getAttribute("user") == null)) { %>
<div class="marginLeft">
    <p>You are not logged in</p>
    <br/>
    <a href="login.jsp">Please Login</a>
</div>
<%} else { %>
<div class="marginLeft">
    <%
        int questionId = 0;
        String topic = null, question = null, askedBy = null, askDate = null, answer = null, answeredBy = null, answerDate = null;

        ArrayList<QuestionAnswer> qAList = (ArrayList<QuestionAnswer>) session.getAttribute("questionAnswers");
        for (QuestionAnswer qA : qAList) {
            if (qA.getQuestionId() == Integer.parseInt(request.getParameter("qid"))) {
                questionId = qA.getQuestionId();
                topic = qA.getTopic();
                question = qA.getQuestion();
                askedBy = qA.getAskedBy();
                askDate = qA.getDateAsked();
                answer = qA.getAnswer();
                answeredBy = qA.getAnsweredBy();
                answerDate = qA.getDateAnswered();
                out.print("<h1> Question ID: " + questionId + "</h1>");
            }
        }
        out.print("<hr>");
    %>
</div>
<form action="answerProcess.jsp?qid=<%out.println(questionId);%>" method="POST">
    <div class="container">
        <label for="question"><b>Question Asked</b></label>
        <br>
        <textarea name="question" id="question" readonly> <%out.println(question);%></textarea>
        <br>
        <label for="answer"><b>Answer</b></label>
        <br>
        <% if (answer == null) { %>
        <textarea placeholder="Answer the question" name="answer" id="answer" required></textarea>
        <br>

        <button type="submit" class="loginbtn">Answer Question</button>
        <%} else { %>
        <textarea name="answer" id="answer" readonly> <%out.println(answer);%></textarea>
        <br>
        <% } %>

        <div class="signin">
            <p><a href="questionsAndAnswers.jsp">Go back to questions list</a>.</p>
        </div>
    </div>
</form>
<% } %>
</body>

</html>