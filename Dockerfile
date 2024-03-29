# syntax=docker/dockerfile:1
FROM openjdk:17-alpine AS BUILDER
WORKDIR /app

# Copy over Maven Wrapper
COPY .mvn/ .mvn
COPY mvnw pom.xml ./

# Copy src files
COPY src ./src

# Create JAR package (don't need to run tests again)
RUN ./mvnw package -DskipTests --no-transfer-progress

# PREPARE RUNNABLE
FROM amazoncorretto:17.0.4-alpine3.15 as RUN

# ENVIRONMENT variable will configure the application
ARG ENVIRONMENT
ENV ENVIRONMENT ${ENVIRONMENT}

WORKDIR /app
COPY --from=BUILDER /app/target/domain-manager.jar ./

EXPOSE 8080
CMD ["java", "-jar", "-Dspring.profiles.active=${ENVIRONMENT}", "domain-manager.jar"]