<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.ZoneId" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%--<%@ taglib prefix="c" uri="①/core" %>--%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%--<%@ taglib prefix="fmt" uri="①/fmt" %> --%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>  <%--<%@ taglib prefix="fn" uri="①/functions" %> --%>
<fmt:setLocale value="ja_JP" />
<%!
    private static Map eventMap = new HashMap();
  static {
    eventMap.put("20190101", "お正月");
    eventMap.put("20191225", "クリスマス");
    eventMap.put("20191231", "大晦日");
  }
%>
<%
  // リクエストのパラメーターから日付を取り出す
  String year = (String)request.getParameter("year");  //String year = (String)request.②("year");
  String month = (String)request.getParameter("month");  //String month = (String)request.②("month");
  String day = (String)request.getParameter("day");  //String day = (String)request.②("day");
  LocalDate localDate = null;
  if (year == null || month == null || day == null) {
    // 日付が送信されていないので、現在時刻を元に日付の設定を行う
    localDate = LocalDate.now();  //localDate = LocalDate.③();
    year = String.valueOf(localDate.getYear());
    month = String.valueOf(localDate.getMonthValue());
    day = String.valueOf(localDate.getDayOfMonth());
  } else {
    //  送信された日付を元に、LocalDateのインスタンスを生成する 
    localDate = LocalDate.String(Integer.valueOf(year), Integer.valueOf(month), Integer.valueOf(day));  
    //???? localDate = LocalDate.④(Integer.⑤(year), Integer.⑤(month), Integer.⑤(day));
  }
  String[] dates = { year, month, day };

  // 画面で利用するための日付、イベント情報を保存
  session.setAttribute("dates", dates);  //⑥.setAttribute("dates", dates);  
  session.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant())); //⑥.setAttribute("date", Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
  
  String event = (String)eventMap.get(year + month + day);
  session.setAttribute("event", event); //⑥.setAttribute("event", event);
%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="UTF-8">
<title>calendar</title>
<style>
ul {
  list-style: none;
}
</style>
</head>
<body>
  <form method="post" action="/jsp/calendar.jsp">  //<form method="⑦" action="/jsp/calendar.jsp">
    <ul>
      <li><input type="text" name="year" value="${param['year']}" /><label for="year">年</label><input type="text" name="month" value="${param['month']}" /><label for="month">月</label><input type="text" name="day" value="${param['day']}" /><label for="day">日</label></li>
      <%--<li><input type="text" name="year" value="${⑧['year']}" /><label for="year">年</label><input type="text" name="month" value="${⑧['month']}" /><label for="month">月</label><input type="text" name="day" value="${⑧['day']}" /><label for="day">日</label></li> --%>
      <li><input type="submit" value="送信" />
      <li><c:out value="${fn:indexOf(dates, '/')}" /> (<fmt:formatDate value="${date}" pattern="E" />)</li>
      <%-- ???? <li><c:out value="${fn:⑨(dates, '/')}" /> (<fmt:⑩ value="${date}" pattern="E" />)</li> --%>
      <li><c:out value="${event}" /></li>
    </ul>
  </form>
</body>
</html>
