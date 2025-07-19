FROM  openjdk:17-jdk-slim
WORKDIR /app
COPY COPY --from=build /build/target/kaddem-0.0.1-SNAPSHOT.jar /app/app.jar
EXPOSE 8089
ENTRYPOINT ["java", "-jar", "app.jar", "--server.port=8089"]
