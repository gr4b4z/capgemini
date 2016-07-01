<%@page pageEncoding="UTF-8" contentType="text/html" trimDirectiveWhitespaces="true"%>
<%@include file="bundle/initialization.jspf" %>
<%@include file="bundle/router.jspf" %>
<c:set var="adminKapp" value="${space.getKapp(Text.defaultIfBlank(space.getAttributeValue('Admin Kapp Slug'),'admin'))}"/>
<c:choose>
    <c:when test="${identity.anonymous}">
        <c:set var="kapp" scope="request" value="${kapp}"/>
        <c:redirect url="/${space.slug}/app/login?kapp=${kapp.slug}"/>
    </c:when>
    <c:otherwise>
        <bundle:layout page="${bundle.path}/layouts/layout.jsp">
            <bundle:variable name="head">
                <title>Kinetic Data ${text.escape(kapp.name)}</title>
            </bundle:variable>
            <!-- Set variable used to count and display submissions -->
            <c:set scope="request" var="submissionsList" value="${SubmissionHelper.retrieveSubmissionsByCompany(kapp.slug, 'Calbro Services', 5)}"/>

            <%-- Set class for number of tiles displayed --%>
            <c:set var="tileCount" value="3" />
            <c:if test="${BundleHelper.checkKappAndForm('admin','user-asset')}">
                <c:set var="tileCount" value="${tileCount - 1}" />
            </c:if>
            <c:if test="${BundleHelper.checkKappAndForm('knowledge','knowledge')}">
                <c:set var="tileCount" value="${tileCount - 1}" />
            </c:if>
            <c:set scope="request" var="tileClass" value="col-sm-${tileCount}"/>
            <%-- Header --%>
            <section class="content-header">
                <ol class="breadcrumb">
                    <li><a href="#">
                        <i class="fa fa-home"></i> 
                        Home</a>
                    </li>
                </ol>
            </section>
            <%-- Action Tiles --%>
            <section class="content">
                <!-- Small boxes (Stat box) -->
                <div class="row">
                    <div class="${tileClass}">
                        <!-- small box -->
                        <div class="small-box bg-aqua">
                            <div class="inner">
                                <h3>${fn:length(submissionsList)}</h3>
                                <p>All Requests</p>
                            </div>
                            <div class="icon">
                                <i class="fa fa-shopping-cart"></i>
                            </div>
                            <a href="${bundle.kappLocation}?page=submissions" class="small-box-footer">View All Requests <i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div><!-- ./col -->

                    <div class="${tileClass}">
                        <!-- small box -->
                        <div class="small-box bg-green">
                            <div class="inner">
                                <h3>${fn:length(SubmissionHelper.retrieveRecentSubmissions('Approval', 'Draft',999))}</h3>
                                <p>My Requests</p>
                            </div>
                            <div class="icon">
                                <i class="fa fa-thumbs-o-up"></i>
                            </div>
                            <a href="${bundle.kappLocation}?page=submissions&type=requests" class="small-box-footer">View Your Request<i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div><!-- ./col -->
                    
<!--                    <div class="${tileClass}">
                         small box 
                        <div class="small-box bg-maroon">
                            <div class="inner">
                                <h3>${fn:length(SubmissionHelper.retrieveRecentSubmissionsByKapp(space.getAttributeValue('QApp Slug'), 'Draft', 999))}</h3>
                                <p>My Approvals</p>
                            </div>
                            <div class="icon">
                                <i class="fa fa-tasks"></i>
                            </div>
                            <a target="_blank" href="${bundle.spaceLocation}/${space.getAttributeValue('QApp Slug')}#/queue/filter/__default__" class="small-box-footer">View Your Tasks <i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div> ./col -->
                    
                    <div class="${tileClass}">
                        <!-- small box -->
                        <div class="small-box bg-maroon">
                            <div class="inner">
                                <h3>${fn:length(SubmissionHelper.retrieveRecentSubmissionsByKapp(space.getAttributeValue('QApp Slug'), 'Draft', 999))}</h3>
                                <p>Servers</p>
                            </div>
                            <div class="icon">
                                <i class="fa fa-tasks"></i>
                            </div>
                           <a href="${bundle.kappLocation}?page=submissions&type=server" class="small-box-footer">View Servers<i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div><!-- ./col -->
                    <div class="${tileClass}">
                        <!-- small box -->
                        <div class="small-box bg-orange">
                            <div class="inner">
                                <h3>Help</h3>
                                <p>&nbsp;</p>
                            </div>
                            <div class="icon">
                                <i class="fa fa-life-ring"></i>
                            </div>
                            <a href="${bundle.spaceLocation}/${kapp.slug}/help" class="small-box-footer">Ask a Question <i class="fa fa-arrow-circle-right"></i></a>
                        </div>
                    </div><!-- ./col -->

                </div><!-- /.row -->

                <div class="row">
                    <div class="col-md-8">
                        <c:import url="${bundle.path}/partials/submissions.jsp" charEncoding="UTF-8"/>
                    </div>
                    <div class="col-md-4">
                        <c:import url="${bundle.path}/partials/promotedRequests.jsp" charEncoding="UTF-8"/>
                    </div>
                </div>
            </section>
        </bundle:layout>
    </c:otherwise>
</c:choose>