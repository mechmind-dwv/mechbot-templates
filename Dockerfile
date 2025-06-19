FROM python:3.10-slim

WORKDIR /app
COPY . .

RUN pip install --upgrade pip && \
    pip install -r backend/requirements.txt && \
    pip install -r tools/requirements.txt && \
    pip install gunicorn

ENV PYTHONUNBUFFERED=1
ENV DJANGO_SETTINGS_MODULE=config.settings

RUN useradd -m myuser && \
    chown -R myuser:myuser /app

USER myuser

EXPOSE 8000

CMD ["gunicorn", "config.wsgi:application", "--bind", "0.0.0.0:8000"]
