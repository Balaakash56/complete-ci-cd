# Stage 1: Build (lightweight)
FROM openjdk:17-slim AS builder
WORKDIR /app
COPY pom.xml ./  # Or build.gradle
COPY src .
RUN mvn package  # Or gradle build

# Stage 2: Final image (slim)
FROM openjdk:17-alpine AS final
WORKDIR /app
COPY --from=builder /app/target/*.jar ./  # Copy JAR file from build stage
EXPOSE 8080  # Expose port for your application
CMD ["java", "-jar", "your-application.jar"]
