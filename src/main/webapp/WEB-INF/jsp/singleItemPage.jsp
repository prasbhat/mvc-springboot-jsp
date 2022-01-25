<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="org.json.*" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>To do Tracker</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
        crossorigin="anonymous">

    <script type="text/javascript">
        function submit(id) {
            var jsonObj = {};
            jsonObj['id']=id;
            jsonObj['title']=document.getElementById('title').value;
            jsonObj['description']=document.getElementById('description').value;
            jsonObj['dueDate']=document.getElementById('dueDate').value;
            jsonObj['status']=document.getElementById('status').value;

            var jsonCommentsArray=[];
            var jsonCommentsObj={};
            jsonCommentsObj["taskComments"]= document.getElementById('taskComments').value;
            jsonCommentsArray.push(jsonCommentsObj);
            jsonObj["todoTaskCommentsSet"] = jsonCommentsArray;

            var fullPath = window.location.href;
            var ctx= "${pageContext.request.contextPath}";
            apiURL = fullPath.substring(0, fullPath.indexOf(ctx)) + ctx;
            var http = new XMLHttpRequest();

            if(id > 0) {
                http.open("PUT", apiURL+"/update", true);
            } else {
                http.open("POST", apiURL+"/create", true);
            }
            http.setRequestHeader("Content-type","application/json");
            http.send(JSON.stringify(jsonObj));
            window.location.href = apiURL+"/";
        }

        function addNewComments(){
            var lTable = document.getElementById("commentsTable");
            lTable.style.display = (lTable.style.display == "table") ? "none" : "table";
        }
    </script>
</head>
<body>
	<div class="container" align="center">
		<h1>To do Tracker Application</h1>

        <table class='table-striped' border='1' align="center">
            <tbody>
                <tr>
                    <th>Title</th>
                    <td>
                        <c:if test="${action == 'view'}">${todoItem.title}</c:if>
                        <c:if test="${action == 'edit'}"><input type="text" name='title' id='title'
                            value='${todoItem.title}' size="35" /></c:if>
                    </td>
                </tr><tr>
                    <th>Description</th>
                    <td>
                        <c:if test="${action == 'view'}">${todoItem.description}</c:if>
                        <c:if test="${action == 'edit'}"><textarea name='description' id='description'
                            rows="3" cols="38">${todoItem.description}</textarea></c:if>
                    </td>
                </tr><tr>
                     <th>Creation Date</th>
                     <td>
                         <fmt:parseDate  value="${todoItem.creationDate}"  type="date" pattern="yyyy-MM-dd" var="parsedDate" />
                         <fmt:formatDate value="${parsedDate}" type="date" pattern="dd-MMM-yyyy" />
                     </td>
                </tr><tr>
                    <th>Due Date</th>
                    <td>
                        <c:if test="${action == 'view'}">
                            <fmt:parseDate  value="${todoItem.dueDate}"  type="date" pattern="yyyy-MM-dd" var="parsedDate" />
                            <fmt:formatDate value="${parsedDate}" type="date" pattern="dd-MMM-yyyy" />
                        </c:if>
                        <c:if test="${action == 'edit'}"><input type="date" name='dueDate' id='dueDate'
                            value='${todoItem.dueDate}'/></c:if>
                    </td>
                </tr><tr>
                    <th>Status</th>
                    <td>
                        <c:if test="${action == 'view'}">${todoItem.status}</c:if>
                        <c:if test="${action == 'edit'}">
                            <select name='status' id='status' value='${todoItem.status}'>
                                <option value="">--Select Status--</option>
                                <c:forEach items="${todoStatus}" var="status">
                                    <option value="${status}"
                                        ${status == todoItem.status ? 'selected="selected"' : ''}>${status}
                                  </option>
                                </c:forEach>
                            </select>
                        </c:if>
                    </td>
                </tr><tr>
                    <th>Comments</th>
                    <td>
                        <c:if test="${todoItem.todoTaskCommentsSet.size() > 0}">
                            <table class='table-bordered'>

                                <thead>
                                    <tr>
                                        <th>Creation Date</th>
                                        <th>Description</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="comments" items="${todoItem.todoTaskCommentsSet}">
                                        <tr>
                                            <td>
                                                <fmt:parseDate  value="${comments.creationDate}"  type="date" pattern="yyyy-MM-dd" var="parsedDate" />
                                                <fmt:formatDate value="${parsedDate}" type="date" pattern="dd-MMM-yyyy" />
                                            </td>
                                            <td><c:out value="${comments.taskComments}"/></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </c:if>
                        <c:if test="${action == 'edit'}">
                        <button class="btn btn-success" onclick=addNewComments()>Add New Comments</button>
                        <table class='table-bordered' id="commentsTable" style="display:none;">
                            <tbody>
                                <tr>
                                    <th>Description</th>
                                    <td><textarea name='description' id='taskComments'
                                    rows="3" cols="38"></textarea></td>
                                </tr>
                            </tbody>
                        </table>
                        </c:if>
                    </td>
                </tr>
                <c:if test="${action == 'edit'}">
                <tr>
                    <td colspan="2" align="center">
                        <button class="btn btn-success" onclick=submit(${todoItem.id})>Submit</button>
                    </td>
                </tr>
                </c:if>
            </tbody>
        </table>
	</div>
</body>
</html>