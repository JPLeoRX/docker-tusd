FROM python:3.8

RUN apt-get update &&\
  apt-get install -y bash curl tar gzip &&\
  rm -rf /var/cache/apt/*
RUN apt-get install ffmpeg libsm6 libxext6 libgl1 bash curl tar gzip -y

RUN \
  mkdir -p /_ &&\
  curl -sL https://github.com/tus/tusd/releases/download/v1.9.1/tusd_linux_amd64.tar.gz | tar xzv -C /_ &&\
  mv /_/tusd_linux_amd64/tusd /bin &&\
  rm -R /_ &&\
  chmod +x /bin/tusd

RUN mkdir -p /srv/tusd-hooks
RUN mkdir -p /srv/tusd-data

RUN pip install requests==2.25.1
RUN pip install injectable==3.4.4
RUN pip install pydantic
RUN pip install simplestr==0.5.0
RUN pip install numpy==1.19.4
RUN pip install opencv-python==4.5.1.48
RUN pip install pillow-heif==0.6.0
RUN pip install google-cloud-storage
RUN pip install tekleo-common-message-protocol==0.0.0.3
RUN pip install tekleo-common-utils==0.0.1.8

EXPOSE 1080
CMD [ "/bin/tusd", "--hooks-dir", "/srv/tusd-hooks", "-behind-proxy"]
