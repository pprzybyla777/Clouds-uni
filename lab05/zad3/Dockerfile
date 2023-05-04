ARG PYTHON_VERSION=3.9

FROM python:${PYTHON_VERSION}

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080

CMD ["python", "serv.py"]