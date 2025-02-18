
FROM python:3.9-slim
WORKDIR /app
COPY app.py .
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# Command to run the application
CMD ["python", "app.py"]
