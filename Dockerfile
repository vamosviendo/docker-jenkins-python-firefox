FROM jenkins/jenkins:2.277.4-lts-jdk11
USER root
RUN apt-get update && apt-get install -y apt-transport-https \
    ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable"
RUN apt-get update && apt-get install -y docker-ce-cli
RUN apt-get install -y firefox-esr build-essential xvfb python3.7-venv python3.7-dev python3-distutils
RUN apt-get install -y wget
RUN wget https://github.com/mozilla/geckodriver/releases/download/v0.29.1/geckodriver-v0.29.1-linux64.tar.gz
RUN apt-get remove -y wget apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN tar -xvzf geckodriver-v0.29.1-linux64.tar.gz
RUN mv geckodriver /usr/local/bin
RUN geckodriver --version
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.24.6 docker-workflow:1.26"
