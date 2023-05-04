ARG PYTHON_VERSION=3.9
ARG APP_PORT=8080

FROM python:${PYTHON_VERSION}-alpine

ENV PORT=${APP_PORT}
ENV VERSION=${PYTHON_VERSION}

WORKDIR /app

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE $APP_PORT

VOLUME [ "/app" ]

CMD ["python3", "serv.py"]