FROM ubuntu
RUN apt-get update -y
RUN apt-get install python3 -y
RUN apt-get install python3-pip  -y
RUN apt-get install git -y
RUN git clone https://github.com/DavidChatak/MLDeployment.git
WORKDIR /MLDeployement
RUN pip3 install -r requirements.txt
CMD python3 flaskapp.py