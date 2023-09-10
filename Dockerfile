# Use an official Python runtime as a parent image
FROM python:3.8-slim

# Set environment variables for Flask
ENV FLASK_APP=userapi.py
#ENV FLASK_RUN_HOST=0.0.0.0
ENV MYSQL_SERVICE_PORT=3306
ENV MYSQL_SERVICE_HOST=localhost
ENV db_name=canada
ENV db_root_password=root


# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y build-essential python3-dev

# Copy the current directory contents into the container
COPY userapi.py /app
COPY requirements.txt /app

RUN ls -lrt
# Install any needed packages specified in requirements.txt
RUN pip install -r requirements.txt
# Make port 80 available to the world outside this container
EXPOSE 8000

# Run app.py with the Flask development server
CMD ["/usr/local/bin/uwsgi", "--http", "0.0.0.0:8000", "--wsgi-file", "userapi.py", "--callable", "app"]
