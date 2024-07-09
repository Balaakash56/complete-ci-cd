# Stage 1: Build (lightweight)
FROM openjdk:17-slim AS builder
WORKDIR /app
COPY pom.xml ./  
COPY src .
RUN mvn package  

# Stage 2: Final image (slim)
FROM openjdk:17-alpine AS final
WORKDIR /app
COPY --from=builder /app/target/*.jar ./  # Copy JAR file from build stage
EXPOSE 8080  # Expose port for  acers
CMD ["java", "-jar", "acers.jar"]
