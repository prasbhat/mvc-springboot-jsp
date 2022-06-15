# mvc-springboot-jsp

This project is an extension of **[microservice-springboot-h2](https://github.com/prasbhat/microservice-springboot-h2/blob/master/README.md)** project, where I have exposed the REST APIs from the Microservice, 
here I am developing a *User Interface (UI)* using the JSP Framework in Spring Boot, for that REST API project.

## Requirements

- [JDK 1.8+](https://www.oracle.com/java/technologies/javase-downloads.html) - Java™ Platform, Standard Edition Development Kit
- [Spring Boot](https://spring.io/projects/spring-boot) - Framework to ease the bootstrapping and development of new Spring Applications
- [Maven](https://maven.apache.org/) - Dependency Management
- [Tomcat](http://tomcat.apache.org/) - The Apache Tomcat® is a Java Servlet container used as web server for running the application
- [Intellij IDEA IDE](https://www.jetbrains.com/idea/download/#section=windows) - An IDE for developing the code. You can use any IDE, I have used Intellij IDEA IDE.

## Running the application locally

There are several ways to run a Spring Boot application on your local machine.

### Using Main method

Clone the repository to your local drive.
```shell
git clone https://github.com/prasbhat/mvc-springboot-jsp.git
```

Import the project as "Maven Project" into your favourite IDE and execute the `main` method in the `MicroserviceSpringbootJSPApplication` class from your IDE.

`Right Click on the file and Run as Java Application`

### Running the application with Maven

Alternatively you can use the [Spring Boot Maven plugin](https://docs.spring.io/spring-boot/docs/current/reference/html/build-tool-plugins-maven-plugin.html) like so:
```shell
git clone https://github.com/prasbhat/mvc-springboot-h2-jsp.git
cd mvc-springboot-jsp
mvn spring-boot:run
```

### Running the application with Executable WAR

The code can also be built into a war and then executed/run. Once the war is built, run the war by using the command:
```shell
git clone https://github.com/prasbhat/mvc-springboot-h2-jsp.git
cd mvc-springboot-jsp
mvn package -DskipTests
java -jar target/mvc-springboot-jsp-0.0.1-SNAPSHOT.war
```

More detailed documentation regarding this project can be found [here](https://myzonesoft.com/post/mvc-springboot-jsp/).