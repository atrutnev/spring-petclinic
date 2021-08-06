FROM openjdk:11-jre-slim
WORKDIR /spring-petclinic
COPY target/spring-petclinic-*.jar spring-petclinic.jar
CMD ["java", "-jar", "spring-petclinic.jar"]