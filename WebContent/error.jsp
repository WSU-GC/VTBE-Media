<%@ taglib uri="/bbNG" prefix="bbNG"%>
<%@ page isErrorPage="true" %>
<bbNG:genericPage authentication="N">
<%
  Throwable error = (Throwable) request.getAttribute("error");
  if( null == error ) error = exception;
  pageContext.setAttribute("error", error);
%>
  <bbNG:error exception="${error}"/>
</bbNG:genericPage>