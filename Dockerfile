FROM openjdk:8

SHELL ["/bin/bash", "-c"]

# install Embulk
RUN curl --create-dirs -o /bin/embulk -L "https://github.com/embulk/embulk/releases/download/v0.11.5/embulk-0.11.5.jar" && \
    chmod +x /bin/embulk

# install JRuby
RUN curl --create-dirs -o ~/jruby-complete-9.1.15.0.jar -L "https://repo1.maven.org/maven2/org/jruby/jruby-complete/9.1.15.0/jruby-complete-9.1.15.0.jar" && \
    chmod +x ~/jruby-complete-9.1.15.0.jar

# setup
RUN mkdir ~/.embulk && echo jruby=file:///root/jruby-complete-9.1.15.0.jar > ~/.embulk/embulk.properties

# install plugins
RUN embulk gem install msgpack -v 1.1.0 && \
    embulk gem install embulk && \
    embulk gem install embulk-input-s3 && \
    embulk gem install embulk-output-redshift