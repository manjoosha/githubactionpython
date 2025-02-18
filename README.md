1. Create a Basic Python Application
     create a file with app.py and add the below content
     print("Hello, Docker!")

2. Create a requirements.txt and add the below libraries
    flask
    requests

3. Create a Dockerfile
   here we need to define how the application has containerized

   # Use an official lightweight Python image
   FROM python:3.9-slim

   # Set the working directory in the container
   WORKDIR /app

   # Copy the application file to the container
   COPY app.py .

   If there are dependencies, copy and install them
   COPY requirements.txt .
   RUN pip install --no-cache-dir -r requirements.txt

# Command to run the application
   CMD ["python", "app.py"]

 4. This GitHub Actions workflow will include the below:

     Build the Docker image
     Log in to Docker Hub
     Push the image to your Docker Hub repository

     Create a .github/workflows/docker-build-push.yml Workflow File

     name: Build and Push Docker Image

on:
  push:
    branches:
      - main  
  workflow_dispatch:  # Allows manual triggering

jobs:
  build-and-push:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Log in to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKER_USERNAME }}
          password: ${{ secrets.DOCKER_PASSWORD }}

      - name: Build Docker image
        run: |
          docker build -t ${{ secrets.DOCKER_USERNAME }}/python-app:latest .

      - name: Push Docker image to Docker Hub
        run: |
          docker push ${{ secrets.DOCKER_USERNAME }}/python-app:latest

5. Set Up Secrets in GitHub
    Go to your GitHub repository:

   Navigate to Settings → Secrets and variables → Actions.
   Click New repository secret.
   Add the following secrets:
   DOCKER_USERNAME: Your Docker Hub username.
   DOCKER_PASSWORD: Your Docker Hub password or an access token.  

6. Push the Code to GitHub
   Run the following in your terminal:  

    git init  
    git add .
    git commit -m "Initial commit"
    git branch -M main  # Ensure your branch is named 'main'
    git remote add origin https://github.com/your-username/your-repo.git
    git push -u origin main

7. Check GitHub Actions
   Once you push your code:

    Go to your GitHub repository.
    Click Actions.
    You should see the workflow running
    After success, check Docker Hub (https://hub.docker.com/r/your-username/python-app) to verify your image

