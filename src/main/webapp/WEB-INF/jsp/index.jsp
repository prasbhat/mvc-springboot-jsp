<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>To do Tracker</title>
    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
        crossorigin="anonymous">

    <script type="text/javascript">
        var fullPath = window.location.href;
        var ctx= "${pageContext.request.contextPath}";
        apiURL = fullPath.substring(0, fullPath.indexOf(ctx)) + ctx;
        var http = new XMLHttpRequest();

        function redirectToSingleView(action, id) {
            window.location.href = apiURL+"/singleItemView/"+action+"/"+id;
        }

        function deleteById(id) {
            http.open("DELETE", apiURL+"/deleteById/"+id, true);
            http.send();
           window.location.reload();
        }
    </script>
</head>
<body>
	<div class="container" align="center">
		<h1>To do Tracker Application</h1>
	    <button class="btn btn-success" onclick=redirectToSingleView('edit','0')>CREATE</button></a>
    </div>
	<table class='table-striped' border='1' align="center">
        <thead>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Due Date</th>
                <th>Status</th>
                <th>No. Of Comments</th>
                <th>View</th>
                <th>Edit</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${todoList}" var="tasks">
                <tr>
                    <td>${tasks.title}</td>
                    <td>${tasks.description}</td>
                    <td>
                        <fmt:parseDate  value="${tasks.dueDate}"  type="date" pattern="yyyy-MM-dd" var="parsedDate" />
                        <fmt:formatDate value="${parsedDate}" type="date" pattern="dd-MMM-yyyy" />
                    </td>
                    <td>${tasks.status}</td>
                    <td align="center">${tasks.todoTaskCommentsSet.size()}</td>
                    <td>
                        <button class="btn btn-success" onclick=redirectToSingleView('view','${tasks.systemTasksId}')>VIEW</button>
                    </td>
                    <td>
                        <button class="btn btn-success" onclick=redirectToSingleView('edit','${tasks.systemTasksId}')>EDIT</button>
                    </td>
                    <td>
                        <button class="btn btn-warning" onclick=deleteById('${tasks.systemTasksId}')>DELETE</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>