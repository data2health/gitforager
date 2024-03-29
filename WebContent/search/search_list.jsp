<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="git" uri="http://icts.uiowa.edu/GitHubTagLib"%>


<!DOCTYPE html>
<html lang="en-US">
<jsp:include page="../head.jsp" flush="true">
    <jsp:param name="title" value="CD2H gitForager" />
</jsp:include>
<style type="text/css" media="all">
@import "../resources/layout.css";
</style>

<body class="home page-template-default page page-id-6 CD2H">
    <jsp:include page="../header.jsp" flush="true" />

    <div class="container pl-0 pr-0">
        <br /> <br />
        <div class="container-fluid">
			<h2>Current Searches</h2>
            <table>
                <tr>
                    <th rowspan=2>ID</th>
                    <th rowspan=2>Term</th>
                    <th rowspan=2># Repos</th>
                    <th rowspan=2># Users</th>
                    <th rowspan=2># Orgs</th>
                    <th colspan=3># Unjudged</th>
                </tr>
                <tr>
                    <th>Users</th>
                    <th>Orgs</th>
                    <th>Repos</th>
                </tr>
			<git:foreachSearchTerm var="x" sortCriteria="term">
			 <git:searchTerm>
                    <tr>
                        <td><git:searchTermID/></td>
                        <td><a href="search.jsp?id=<git:searchTermID/>"><git:searchTermTerm/></a></td>
                        <td>${git:searchRepositoryCountBySearchTerm(tag_searchTerm.getID()+"") }</td>
                        <td>${git:searchUserCountBySearchTerm(tag_searchTerm.getID()+"") }</td>
                        <td>${git:searchOrganizationCountBySearchTerm(tag_searchTerm.getID()+"") }</td>
                        <td>
                            <sql:query var="rels" dataSource="jdbc/GitHubTagLib">
                                select count(*) as count from github.search_user where relevant is null and sid = ?::int
                                <sql:param>${tag_searchTerm.getID()}</sql:param>
                            </sql:query>
                            <c:forEach items="${rels.rows}" var="row">
                                <c:if test="${row.count > 0}">
                                    <a href="<util:applicationRoot/>/user/user.jsp?sid=${tag_searchTerm.getID()}">${row.count}</a>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <sql:query var="rels" dataSource="jdbc/GitHubTagLib">
                                select count(*) as count from github.search_organization where relevant is null and sid = ?::int
                                <sql:param>${tag_searchTerm.getID()}</sql:param>
                            </sql:query>
                            <c:forEach items="${rels.rows}" var="row">
                                <c:if test="${row.count > 0}">
                                    <a href="<util:applicationRoot/>/organization/organization.jsp?sid=${tag_searchTerm.getID()}">${row.count}</a>
                                </c:if>
                            </c:forEach>
                        </td>
                        <td>
                            <sql:query var="rels" dataSource="jdbc/GitHubTagLib">
                                select count(*) as count from github.search_repository where relevant is null and sid = ?::int
                                <sql:param>${tag_searchTerm.getID()}</sql:param>
                            </sql:query>
                            <c:forEach items="${rels.rows}" var="row">
                                <c:if test="${row.count > 0}">
                                    <a href="<util:applicationRoot/>/repository/repository.jsp?sid=${tag_searchTerm.getID()}">${row.count}</a>
                                </c:if>
                            </c:forEach>
                        </td>
                    </tr>
			 </git:searchTerm>
			</git:foreachSearchTerm>
			</table>

            <form action="addSearch.jsp">
            Add a search:
            <input name="term" size=50>
            <input type=submit name=submitButton value=add>
            </form>
            </div>
            <div style="width: 100%; float: left">
                <jsp:include page="../footer.jsp" flush="true" />
            </div>
        </div>
    </div>
</body>

</html>

