# Use a base image with Tomcat
FROM tomcat:10.1.19

# Copy the WAR file into the appropriate location in the container
COPY Pawfect_Match_Web.war /usr/local/tomcat/webapps/

# Set up environment variables or other configurations if needed
ENV JAVA_OPTS="-Xmx256m -Xms256m"

# Expose the port that Tomcat runs on
EXPOSE 8080

# Command to start Tomcat
CMD ["catalina.sh", "run"]
