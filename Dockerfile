# syntax=docker/dockerfile:1
FROM python:3.12-slim

# 1) Déclare un répertoire de travail
WORKDIR /app

# 2) Dépendances
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 3) Code + données embarquées (image immuable de base)
COPY app.py .
COPY data ./data

# 4) Port exposé
EXPOSE 5000

# 5) Commande par défaut (prod-like)
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app"]
