FROM ubuntu:12.04
MAINTAINER "Andy Do"
RUN apt-get update
RUN apt-get install -y software-properties-common python-software-properties
#Install Git
RUN \
   add-apt-repository ppa:git-core/ppa && \
   apt-get update && \
   apt-get install -y git

# Install Java
RUN \
   echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
   add-apt-repository -y ppa:webupd8team/java && \
   apt-get update && \
   apt-get install -y oracle-java8-installer && \
   apt-get install -y curl && \
   rm -rf /var/lib/apt/lists/* && \
   rm -rf /var/cache/oracle-jdk8-installer
RUN rm -rf /usr/local/src

# DynamoDB
RUN mkdir /app
RUN /usr/bin/curl -L http://dynamodb-local.s3-website-us-west-2.amazonaws.com/dynamodb_local_latest | /bin/tar -xz -C /app
ENTRYPOINT ["/usr/bin/java", "-Djava.library.path=/app/DynamoDBLocal_lib", "-jar", "/app/DynamoDBLocal.jar"]
# Define working directory.
WORKDIR /data

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

# Define default command.
CMD ["bash"]

