FROM maven:3.8.6-eclipse-temurin-11 as build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

FROM eclipse-temurin:11-jre
WORKDIR /app
COPY --from=build /app/target/your-app.jar /app/app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
