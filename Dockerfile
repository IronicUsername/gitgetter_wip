FROM python:3.7-slim

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONPATH=/app/src

RUN apt-get update && apt-get install -y curl

RUN curl -sSL https://raw.githubusercontent.com/sdispater/poetry/master/get-poetry.py | python && \
    . $HOME/.poetry/env && \
    poetry config virtualenvs.create false && \
    rm -rf ~/.cache/pip

COPY pyproject.toml poetry.lock /app/
RUN . $HOME/.poetry/env && \
    poetry install --no-dev && \
    rm -rf ~/.cache/pip

COPY . .

EXPOSE 5000

CMD ["python", "-m", "gitgetter"]
