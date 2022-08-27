<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<c:if test="${param.term != '' }">
	<sql:update dataSource="jdbc/GitHubTagLib">
	    insert into github.search_term(term) values(?);
	    <sql:param value="${param.term}" />
	</sql:update>
</c:if>
<c:redirect url="search_list.jsp" />
