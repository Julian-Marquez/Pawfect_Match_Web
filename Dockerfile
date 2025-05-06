# Use official Tomcat base image
FROM tomcat:10.1-jdk17

# Remove default webapps to prevent conflicts (optional but recommended)
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your WAR file into the Tomcat webapps directory
COPY Pawfect_Match_Web.war /usr/local/tomcat/webapps/ROOT.war

# Set environment variables (adjust memory as needed)
ENV JAVA_OPTS="-Xmx256m -Xms256m"

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat
CMD ["catalina.sh", "run"]
