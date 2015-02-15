FROM ubuntu:14.04
MAINTAINER Aarij Siddiqui <siddiqui ÄT dbis.rwth-aachen.de>
# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Update base image
RUN sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
RUN apt-get update -y
RUN apt-get upgrade -y

# Install build tools
RUN apt-get install -y \
                     openjdk-7-jdk

# Set jdk7 as the default JDK
RUN ln -fs /usr/lib/jvm/java-7-openjdk-amd64/jre/bin/java /etc/alternatives/java

# Install Tomcat Server

# Create installation directory
RUN mkdir /mnt/dockerdemo 
RUN mkdir /mnt/dockerdemo/server 
RUN mkdir /mnt/dockerdemo/server/tomcat

# Download Tomcat Server
RUN wget http://mirror.netcologne.de/apache.org/tomcat/tomcat-8/v8.0.18/bin/apache-tomcat-8.0.18.tar.gz -O  /mnt/tempdircopy/apache-tomcat-8.0.18.tar.gz
RUN tar -zxvf /mnt/tempdircopy/apache-tomcat-8.0.18.tar.gz -C /mnt/tempdircopy

# Copy the tomcat to the right location
RUN cp -r /mnt/tempdircopy/apache-tomcat-8.0.18/* /mnt/dockerdemo/server/tomcat

# Start Tomcat Server
RUN sh /mnt/docker/server/tomcat/bin/startup.sh
