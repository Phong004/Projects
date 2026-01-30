FROM tomcat:10.1-jdk11 AS tomcat_server

FROM eclipse-temurin:11-jdk-alpine AS builder

# Set working directory
WORKDIR /app

COPY . .

# Create folder web
RUN mkdir -p web/WEB-INF/classes
RUN mkdir -p web/WEB-INF/lib

RUN cp lib/*.jar web/WEB-INF/lib
RUN find src/java -type f -not -name "*.java" -exec cp --parents {} web/WEB-INF/classes \; && \
    mv web/WEB-INF/classes/src/java/* web/WEB-INF/classes/ && \
    rm -rf web/WEB-INF/classes/src

# Copy servlet-api
COPY --from=tomcat_server /usr/local/tomcat/lib/servlet-api.jar web/WEB-INF/lib/
COPY --from=tomcat_server /usr/local/tomcat/lib/jsp-api.jar web/WEB-INF/lib/
COPY --from=tomcat_server /usr/local/tomcat/lib/el-api.jar web/WEB-INF/lib/

# Compile code
RUN find src/java -name "*.java" > sources.txt && \
    javac -encoding UTF-8 \
    -cp "web/WEB-INF/lib/*" \
    -d web/WEB-INF/classes \
    @sources.txt

# Runtime
FROM tomcat:10.1-jdk11

# Remove default application on Tomcat to secure
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy files in folder "build" to 'ROOT'
COPY --from=builder /app/web /usr/local/tomcat/webapps/ROOT

EXPOSE 8080

CMD [ "catalina.sh", "run" ]