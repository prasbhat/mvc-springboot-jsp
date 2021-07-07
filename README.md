# microservice-springboot-h2-jsp

This project is an extension
of **[microservice-springboot-h2](https://github.com/prasbhat/microservice-springboot-h2/blob/master/README.md)**
project, here I am developing a frontend using the JSP Framework.

When using JSP files with Spring Boot, one disadvantage is we cannot use **jar** for packaging the project. We need to
package the project as a ***war***.

We will be making the following changes, in order to make our Spring Boot project work with JSP.

- We need to add this line in the _pom.xml_, because by default pom.xml would package the project into jar.

```
<packaging>war</packaging>
```

- Add the following dependencies to the _pom.xml_ for JSP to be processed.

```
<dependency>
	<groupId>org.apache.tomcat.embed</groupId>
	<artifactId>tomcat-embed-jasper</artifactId>
	<scope>provided</scope>
</dependency>
<dependency>
	<groupId>javax.servlet</groupId>
	<artifactId>jstl</artifactId>
	<scope>provided</scope>
</dependency>
```

- We should inform Spring Boot to process the JSP files, so need to add following lines to the _/src/main/resources/application.properties_ file.

```
spring.mvc.view.prefix=/WEB-INF/jsp/
spring.mvc.view.suffix=.jsp
```

- Add 2 new JSP files: _index.jsp_ and _singleItemPage.jsp_ under _/src/main/webapp/WEB-INF/jsp/_ folder.

- Add below 2 methods to the Controller Java Class: _TodoController.java_, in order to make calls to the respective JSP files.
```
@GetMapping("/")
public ModelAndView gotoHome(ModelMap model) {
    model.put("todoList", findAllTodoList());
    return new ModelAndView("index");
}
```
```
@GetMapping("/singleItemView/{action}/{todoId}")
public ModelAndView goToSingleItemView(ModelMap model, @PathVariable("action") String action,
                                       @PathVariable("todoId") String todoId){
    if(Long.parseLong(todoId) != 0) {
        model.put("todoItem", findById(Long.parseLong(todoId)));
    } else {
        model.put("todoItem", new Todo(0L, "", "", LocalDate.now(), ""));
    }
    model.put("action",action);
    model.put("todoStatus",getTodoStatus());
    return new ModelAndView("singleItemPage");
}
```

## Requirements

- [JDK 1.8+](https://www.oracle.com/java/technologies/javase-downloads.html) - Java™ Platform, Standard Edition
  Development Kit
- [Spring Boot](https://spring.io/projects/spring-boot) - Framework to ease the bootstrapping and development of new
  Spring Applications
- [Maven](https://maven.apache.org/) - Dependency Management
- [Tomcat](http://tomcat.apache.org/) - The Apache Tomcat® is a Java Servlet container used as web server for running
  the application
- [Intellij IDEA IDE](https://www.jetbrains.com/idea/download/#section=windows) - An IDE for developing the code. You
  can use any IDE, I have used Intellij IDEA IDE.

## Running the application locally

There are several ways to run a Spring Boot application on your local machine.

### Using Main method

Clone the repository to your local drive.

```shell
git clone https://github.com/prasbhat/microservice-springboot-h2-jsp.git
```

Import the project as "Maven Project" into your favourite IDE and execute the `main` method in
the  `com.myzonesoft.microservice.todo.MicroserviceSpringbootH2JSPApplication` class from your IDE.

`Right Click on the file and Run as Java Application`

### Running the application with Maven

Alternatively you can use
the [Spring Boot Maven plugin](https://docs.spring.io/spring-boot/docs/current/reference/html/build-tool-plugins-maven-plugin.html)
like so:

```shell
git clone https://github.com/prasbhat/microservice-springboot-h2-jsp.git
cd microservice-springboot-h2-jsp
mvn spring-boot:run
```

### Running the application with Executable WAR

The code can also be built into a war and then executed/run. Once the war is built, run the war by using the command:

```shell
git clone https://github.com/prasbhat/microservice-springboot-h2-jsp.git
cd microservice-springboot-h2-jsp
mvn package -DskipTests
java -jar target/microservice-springboot-h2-jsp-0.0.1-SNAPSHOT.war
```