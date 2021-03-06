# set base image (host OS)
FROM python:3.8

# set the working directory in the container
WORKDIR /etl

# copy the dependencies file to the working directory
COPY requirements.txt .

# install dependencies
RUN pip3 install -r requirements.txt

# copy the content of the local directory to the working directory
COPY . .

# command to run on container start
CMD [ "python", "./app.py" ]