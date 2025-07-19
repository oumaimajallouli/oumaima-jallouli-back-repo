# ----------- Build Stage -----------
FROM maven:3.8.6-openjdk-17 AS build
WORKDIR /build

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# ----------- Run Stage -----------
FROM openjdk:17-jdk-slim
WORKDIR /app

COPY --from=build /build/target/kaddem-0.0.1-SNAPSHOT.jar /app/app.jar

EXPOSE 8089
ENTRYPOINT ["java", "-jar", "app.jar", "--server.port=8089"]
