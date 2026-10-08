FROM eclipse-temurin:21-jre

WORKDIR /app

COPY app.jar /app/app.jar

EXPOSE 8081

HEALTHCHECK CMD curl -f http://localhost:8081

CMD ["java", "--add-modules", "jdk.httpserver", "-jar", "/app/app.jar"]

