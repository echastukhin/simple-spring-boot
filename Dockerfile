FROM openjdk:8-jdk-alpine
COPY target/ping-pong-${project.version}.jar /
EXPOSE 8085 
ENTRYPOINT ["java", "-jar", "/ping-pong-${project.version}.jar"]
