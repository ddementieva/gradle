There is no Gradle integration with Codenvy right now, but we have issue registered on that. 

Currently, you can build your project with Gradle, using custom Dockerfile (you can create it at the Runner panel > Configs tab, Create New button). 
Your Dockerfile recipe can look like this:
# Here we are taking codenvy/jdk7 image as a base
FROM codenvy/jdk7

# Download Gradle binaries
RUN wget -P /home/user/ --quiet https://services.gradle.org/distributions/gradle-2.3-bin.zip
RUN cd /home/user/ && unzip gradle-2.3-bin.zip && rm -rf gradle-2.3-bin.zip
 
# Setting environment variables
ENV GRADLE_HOME /home/user/gradle-2.3
RUN echo 'export GRADLE_HOME=$GRADLE_HOME' >> /home/user/.bashrc
ENV PATH $GRADLE_HOME/bin:$PATH
RUN echo "export PATH=$PATH" >> /home/user/.bashrc

# Mounting project sources
VOLUME ["/home/user/app"]
ENV CODENVY_APP_BIND_DIR /home/user/app

# Here you can add any command you need (such as gradle build etc.). sleep 365d keeps runner alive.
CMD sleep 365d
