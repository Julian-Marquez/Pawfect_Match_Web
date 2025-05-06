FROM tomcat:10.1

# Copy WAR file into webapps
COPY Pawfect_Match_Web.war /usr/local/tomcat/webapps/

# Add custom startup script
COPY start.sh /usr/local/tomcat/bin/
RUN chmod +x /usr/local/tomcat/bin/start.sh

# Use custom startup script
CMD ["/usr/local/tomcat/bin/start.sh"]
