FROM sequenceiq/spark:1.6.0

MAINTAINER Analysis, Computing and Engineering Solutions, Incorporated (ACES, Inc)

ADD data/data.tar.gz /

ADD scripts/start-spark-shell.sh /spark/
CMD /spark/start-spark-shell.sh
