FROM openjdk:8-jdk-alpine
RUN addgroup -S manug && adduser -S manug -G manug
USER manug:manug
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar

EXPOSE 8500

ENTRYPOINT ["java","-jar","/app.jar"]