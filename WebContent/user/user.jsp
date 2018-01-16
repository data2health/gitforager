<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="util" uri="http://icts.uiowa.edu/tagUtil"%>
<%@ taglib prefix="git" uri="http://icts.uiowa.edu/GitHubTagLib"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>gitForager 1.0 - User</title>
<style type="text/css" media="all">
@import "<util:applicationRoot/>/resources/style.css";
</style>
</head>
<body>
	<div id="content"><jsp:include page="/header.jsp" flush="true" />
		<jsp:include page="/menu.jsp" flush="true"><jsp:param
				name="caller" value="research" /></jsp:include><div id="centerCol">
			<git:user ID="${param.id}">
				<h2>
					<git:userName />
				</h2>

				<p>
					<b>Login:</b>
					<git:userLogin />
				</p>
				<p>
					<b>Company:</b>
					<git:userCompany />
				</p>
				<p>
					<b>Location:</b>
					<git:userLocation />
				</p>
				<p>
					<b>email:</b>
					<git:userEmail />
				</p>
				<p>
					<b>Bio:</b>
					<git:userBio />
				</p>
            <p><b>Blog:</b>
            <c:choose>
            <c:when test="${fn:startsWith(git:userBlogValue(),'http')}">
             <a href="<git:userBlog/>"><git:userBlog/></a>
            </c:when>
            <c:otherwise>
             <a href="http://<git:userBlog/>"><git:userBlog/></a>
            </c:otherwise>
            </c:choose>
            </p>
				<p>
					<b>Blog:</b>
					<git:userBlog />
				</p>

                <c:if test="${git:userHasMember(param.id)}">
                    <h3>Member of </h3>
                    <ol class="bulletedList">
                        <git:foreachMember var="x" useOrganization="true" sortCriteria="name">
                            <git:member>
                                <c:set var="oid" value="${git:memberOrganizationIdValue()}" />
                                <git:organization ID="${oid}">
                                    <li><a href="<util:applicationRoot/>/organization/organization.jsp?id=<git:organizationID/>"><git:organizationName /></a>
                                </git:organization>
                            </git:member>
                        </git:foreachMember>
                    </ol>
                </c:if>

			<h3>Repositories</h3>
			<dl>
				<git:foreachUserRepo var="x" useRepository="true" sortCriteria="name">
					<git:userRepo>
						<c:set var="rid" value="${git:userRepoRepositoryIdValue()}" />
						<git:repository ID="${rid}">
							<dt>
								<a
									href="<util:applicationRoot/>/repository/repository.jsp?id=<git:repositoryID/>"><git:repositoryName /></a>
							</dt>
							<dd>
								<git:repositoryDescription />
							</dd>
						</git:repository>
					</git:userRepo>
				</git:foreachUserRepo>
			</dl>

            </git:user>

			<jsp:include page="/footer.jsp" flush="true" /></div>
	</div>
</body>
</html>

