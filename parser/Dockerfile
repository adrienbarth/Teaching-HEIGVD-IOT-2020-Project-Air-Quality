FROM java:8-jdk-alpine
COPY ./parser.jar /usr/app/
WORKDIR /usr/app
ENTRYPOINT ["java", "-jar", "parser.jar"]