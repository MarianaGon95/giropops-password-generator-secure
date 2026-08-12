FROM cgr.dev/chainguard/python:latest-dev AS builder

WORKDIR /app

RUN python -m venv /app/venv

COPY requirements.txt .

RUN /app/venv/bin/pip install --no-cache-dir -r requirements.txt

COPY . .

FROM cgr.dev/chainguard/python:latest

WORKDIR /app

COPY --from=builder /app /app

EXPOSE 5000

ENTRYPOINT ["/app/venv/bin/python", "/app/app.py"]