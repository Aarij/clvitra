FROM ubuntu:14.04
MAINTAINER Aarij Siddiqui <siddiqui ÄT dbis.rwth-aachen.de>
# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Update base image
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update -y
#RUN apt-get upgrade -y

# Install build tools
RUN apt-get install -y \
                     openjdk-7-jdk \
                     wget

# Set jdk7 as the default JDK
RUN ln -fs /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java /etc/alternatives/java

# Install Tomcat Server

# Create installation directory
RUN mkdir /dockerdemo 
RUN mkdir /dockerdemo/server 
RUN mkdir /dockerdemo/server/tomcat
RUN mkdir /tempdircopy
# Download Tomcat Server
RUN wget http://mirror.netcologne.de/apache.org/tomcat/tomcat-8/v8.0.18/bin/apache-tomcat-8.0.18.tar.gz -O  /tempdircopy/apache-tomcat-8.0.18.tar.gz
RUN tar -zxvf /tempdircopy/apache-tomcat-8.0.18.tar.gz -C /tempdircopy

# Copy the tomcat to the right location
RUN cp -r /tempdircopy/apache-tomcat-8.0.18/* /dockerdemo/server/tomcat



# Start Tomcat Server
RUN sh /docker/server/tomcat/bin/startup.sh
