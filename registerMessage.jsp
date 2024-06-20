<%@ page language="java" contentType="text/html; charset=UTF-8" 
    pageEncoding="UTF-8"%>
<% // セッションの有効期限設定
  session.setMaxInactiveInterval(180); //session.setMaxInactiveInterval(①);
  String logout = (String)request.getParameter("logout");
  String message = null;
  if (logout != null && logout.equals("true")) {
    // セッションの破棄
    session.invalidate(); // session.②();
  } else {
    // GETパラメータから「メッセージ」を取り出す
    message = (String)request.getParameter("message"); //message = (String)request.③("message");
    if (message != null) {
      // 「メッセージ」が送信されていたので、セッションに保存
      session.setAttribute("message", message); //session.④("message", message);
    } else {
      // 「メッセージ」が送信されていなかったので、セッションからメッセージを取得
      message = (String)session.getAttribute("message");  //message = (String)session.⑤("message");
    }
  }
  if (message == null) message = "";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>registerMessage</title>
<style>
ul {
  list-style: none;
}
</style>
</head>
<body>
 <form method="GET" action="/jsp/registerMessage.jsp">
    <ul>
      <li><label for="message">メッセージ</label><input type="text" name="message" value="<%= message %>"/></li>
      <li>
        <input type="submit" value="登録" />
        <a href="/jsp/registerMessage.jsp?logout=logout">ログアウト</a>  <%--<a href="/jsp/registerMessage.jsp?⑥">ログアウト</a>  ログアウトのための操作をいれればいい？不明--%>
      </li>
    </ul>
  </form>
</body>
</html>