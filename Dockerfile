# Use an official Tomcat runtime as the parent image
FROM tomcat:9.0.45-jdk11-openjdk-slim

# Remove the default webapps that come with Tomcat
RUN rm -rf $CATALINA_HOME/webapps/*

# Copy your own war file into the container
COPY myapp.war $CATALINA_HOME/webapps/ROOT.war

# Expose the default Tomcat port
EXPOSE 8080

# Start Tomcat when the container launches
CMD ["catalina.sh", "run"]
