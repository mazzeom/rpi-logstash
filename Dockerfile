FROM arm64v8/ubuntu:20.04
MAINTAINER fine <dlgmltjr0925@gmail.com>

RUN apt-get update && apt-get install openjdk-11-jre wget gnupg -y 

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add - \
 && apt-get install apt-transport-https \
 && echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list \
 && apt-get update \
 && apt-get install logstash -y 

COPY config/logstash /usr/share/logstash/config/
COPY config/pipeline/default.conf /usr/share/logstash/pipeline/logstash.conf

EXPOSE 9600 5044

ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-arm64/
ENV PATH JAVA_HOME/bin:$PATH
ENV PATH /usr/share/logstash/bin:$PATH

CMD ["/bin/bash", "-c", "logstash"]
