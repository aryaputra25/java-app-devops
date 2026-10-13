FROM eclipse-temurin:21-jre

WORKDIR /app

COPY build/app.jar /app/app.jar

EXPOSE 8081

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 CMD curl -f http://localhost:8081 || exit 1

CMD ["java", "--add-modules", "jdk.httpserver", "-jar", "/app/app.jar"]

