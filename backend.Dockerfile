# Use a lightweight Python image with Alpine Linux
FROM python:3.9-alpine as flask-build

# Set the working directory to /app
WORKDIR /app

# Copy main.py and requirements.txt to the working directory
COPY main.py requirements.txt ./

# Install Python dependencies from requirements.txt
RUN pip3 install --no-cache-dir -r requirements.txt

# Set environment variables for Flask application
ENV FLASK_APP=main.py
ENV FLASK_DEBUG=1

# Expose port 5000 to allow external connections
EXPOSE 5000

# Specify the command to run the Flask application
CMD ["python3", "-m", "flask", "run", "--host=0.0.0.0"]
