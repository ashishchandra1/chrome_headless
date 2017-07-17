FROM ubuntu:latest

LABEL name="chrome-headless" \ 
            maintainer="Ashish <ashish@propertyfinder.ae>" \
            version="0.1" \
            description="Google Chrome Headless in a container"

# Install utilities
RUN apt-get update --fix-missing && apt-get -y upgrade &&\
apt-get install -y sudo curl wget unzip git

# Install Chrome for Ubuntu
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - &&\
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list' &&\
sudo apt-get update &&\
sudo apt-get install -y google-chrome-unstable

# Add a  chrome user and give it a sudo privileges

RUN useradd -m chromeuser &&\
sudo adduser chromeuser sudo

USER chromeuser

# Expose port 9222
EXPOSE 9222

ENTRYPOINT ["google-chrome"]
CMD [ "--headless", "--disable-gpu", "--remote-debugging-address=0.0.0.0", "--remote-debugging-port=9222" ]
