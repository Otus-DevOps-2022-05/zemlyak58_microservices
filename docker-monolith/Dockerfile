FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y mongodb ruby-full ruby-bundler build-essential git
# RUN apt-get install -y mongodb-server ruby-full ruby-dev build-essential git
RUN git clone -b monolith https://github.com/express42/reddit.git
# RUN gem install bundler

COPY mongod.conf /etc/mongodb.conf
COPY db_config /reddit/db_config
COPY start.sh /start.sh
COPY reddit.service /etc/systemd/system/reddit.service

RUN cd /reddit && rm Gemfile.lock && bundle install
RUN chmod 0777 /start.sh

CMD ["/start.sh"]
