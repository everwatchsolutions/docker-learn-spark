FROM sequenceiq/hadoop-docker:2.7.1
MAINTAINER Analysis, Computing and Engineering Solutions, Incorporated (ACES, Inc)

USER root

# install dev tools
RUN yum clean all; \
    rpm --rebuilddb; \
    yum install -y wget
RUN yum update -y libselinux


# java
RUN wget -c --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.rpm -O /tmp/jdk.rpm

RUN rpm -i /tmp/jdk.rpm
RUN rm -f /tmp/jdk.rpm

ENV JAVA_HOME /usr/java/default
ENV PATH $PATH:$JAVA_HOME/bin
RUN rm /usr/bin/java && ln -s $JAVA_HOME/bin/java /usr/bin/java


#support for Hadoop 2.7.1
RUN curl -s http://apache.cs.utah.edu/spark/spark-2.2.1/spark-2.2.1-bin-hadoop2.7.tgz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s spark-2.2.1-bin-hadoop2.7 spark
ENV SPARK_HOME /usr/local/spark
RUN mkdir $SPARK_HOME/yarn-remote-client
ADD files/yarn-remote-client $SPARK_HOME/yarn-remote-client

RUN $BOOTSTRAP && $HADOOP_PREFIX/bin/hadoop dfsadmin -safemode leave && $HADOOP_PREFIX/bin/hdfs dfs -put $SPARK_HOME-2.2.1-bin-hadoop2.7/jars /spark

ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop
ENV PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin
# update boot script
COPY files/bootstrap.sh /etc/bootstrap.sh
RUN chown root.root /etc/bootstrap.sh
RUN chmod 700 /etc/bootstrap.sh

#install R
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum -y install R

#add data
ADD data/data.tar.gz /

ENTRYPOINT ["/etc/bootstrap.sh"]
