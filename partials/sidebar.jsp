<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="../bundle/initialization.jspf" %>

<!-- Left side column. contains the logo and sidebar -->
<aside class="main-sidebar">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
        <!-- sidebar menu: : style can be found in sidebar.less -->
        <ul class="sidebar-menu">
            <li <c:if test="${activePage eq 'home'}">class="active"</c:if> >
                <a href="${bundle.kappLocation}">
                    <i class="fa fa-home"></i> <span>Home</span>
                </a>
            </li>
            <li <c:if test="${activePage eq 'all-request'}">class="active"</c:if> >
                <a href="${bundle.kappLocation}?page=submissions">
                    <i class="fa fa-shopping-cart"></i> <span>All Requests</span>
                </a>
            </li>
            <li <c:if test="${activePage eq 'requests'}">class="active"</c:if> >
                <a href="${bundle.kappLocation}?page=submissions&type=requests">
                    <i class="fa fa-thumbs-o-up"></i> <span>My Requests</span>
                </a>
            </li>
<!--            <li <c:if test="${activePage eq 'approval'}">class="active"</c:if> >
                <a href="${bundle.kappLocation}?page=submissions&type=approval">
                    <i class="fa fa-tasks"></i> <span>My Approvals</span>
                </a>
            </li>-->
            <li <c:if test="${activePage eq 'server'}">class="active"</c:if> >
                <a href="${bundle.kappLocation}?page=submissions&type=server">
                    <i class="fa fa-tasks"></i> <span>Server</span>
                </a>
            </li>
            <li <c:if test="${activePage eq 'work-order'}">class="active"</c:if> >
                <a href="${bundle.spaceLocation}/${kapp.slug}/help">
                    <i class="fa fa-life-ring"></i> <span>Help</span>
                </a>
            </li>
            <li>
                <!-- search form -->
                <c:choose>
                    <c:when test="${not empty space.getKapp('search') && (empty kapp || kapp.hasAttribute('Include in Global Search') || text.equals(kapp.slug, 'search'))}">
                        <form action="${bundle.spaceLocation}/search" method="GET" class="sidebar-form">
                            <div class="input-group">
                                <c:if test="${not empty kapp}">
                                    <input type="hidden" value="${text.equals(kapp.slug, "search") ? param["source"] : kapp.slug}" name="source">
                                </c:if>
                                <input type="text" name="q" placeholder="Global Search" value="${param["q"]}">
                                <span class="input-group-btn">
                                    <button type="submit" id="search-btn" class="btn btn-flat states"><i class="fa fa-search"></i></button>
                                </span>
                            </div>
                        </form>
                    </c:when>
                    <c:when test="${not empty kapp}">
                        <form action="${bundle.kappLocation}" method="GET" class="sidebar-form">
                            <div class="input-group">
                                <input type="hidden" value="search" name="page">
                                <input type="text" name="q" class="form-control" placeholder="Search..." value="${param["q"]}">
                                <span class="input-group-btn">
                                    <button type="submit" id="search-btn" class="btn btn-flat states"><i class="fa fa-search"></i></button>
                                </span>
                            </div>
                        </form>
                    </c:when>
                </c:choose>
                <!-- /.search form -->
            </li>
            <li class="header">Marketplace Catalog</li>
            <li class="view-all-categories">
                <!-- Sidebar toggle button-->
                <a href="${bundle.kappLocation}?page=categories" >
                    <i class="fa fa-sitemap"></i>
                    <span>View all categories</span>
                    <i class="fa fa-angle-right pull-right"></i>
                </a>
            </li>
            <%-- For each of the categories --%>
            <c:forEach items="${CategoryHelper.getCategories(kapp)}" var="category">
                <c:set var="formsStatusActive" value="${FormHelper.getFormsByStatus(category.category,'Active')}"/>
                <%-- If the category is not hidden, and it contains at least 1 form --%>
                <c:if test="${fn:toLowerCase(category.getAttribute('Hidden').value) ne 'true' && not formsStatusActive}">
                        <%-- Set Classes in LI Based on active page and if there are non-empty subcategories --%>
                        <li class="parent <c:if test="${param['category'] eq category.slug}">active</c:if>" data-forms="${fn:length(category.forms)}">
                            <a href="${bundle.kappLocation}?page=category&category=${text.escape(category.slug)}">
                                <span>${text.escape(category.name)}</span>
                                <%-- If Subs exist, angle-left, otherwise show form count --%>
                                <c:if test="${category.hasNonEmptySubcategories()}">
                                    <i class="fa fa-angle-right pull-right <c:if test="${category.hasNonEmptySubcategories()}">treeview</c:if>"></i>
                                </c:if>
                            </a>
                            <c:if test="${category.hasNonEmptySubcategories()}">
                                <c:set var="sidebarSubCat" value="${category}" scope="request"/>
                                <jsp:include page="sidebarSubCategory.jsp"/>
                            </c:if>
                        </li>
                </c:if>
            </c:forEach>
            <c:if test="${fn:toLowerCase(identity.user.getAttribute('Catalog Manager').value) eq 'true'}">
                <li <c:if test="${activePage eq 'dashboard'}">class="active"</c:if> >
                    <a href="${bundle.kappLocation}?page=dashboard">
                        <i class="fa fa-tachometer"></i> <span>Management Dashboard</span>
                    </a>
                </li>
            </c:if>
            <li class="sidebar-include-toggle">
                <!-- Sidebar toggle button-->
                <a href="#" class="sidebar-toggle hidden-xs text-right" data-toggle="offcanvas" role="button">
                    <i class="fa fa-angle-left"></i><i class="fa fa-angle-right"></i>
                    <span class="sr-only">Toggle navigation</span>
                </a>
            </li>
        </ul>
    </section>
    <!-- /.sidebar -->
</aside>