FROM python:3.10-slim
WORKDIR /app
RUN echo 'from http.server import SimpleHTTPRequestHandler, test; test(SimpleHTTPRequestHandler)' > server.py
EXPOSE 8000
CMD ["python", "server.py"]
