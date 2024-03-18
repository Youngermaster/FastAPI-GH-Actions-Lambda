# FastAPI GitHub Actions AWS Lambda

This is a FastAPI project that is deployed to AWS Lambda using GitHub Actions.

## Usage

> **Note:** Make sure to update the .env file, you can use the .env.example file as a template.

```bash
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
python app/main.py
```

## Run with Docker

```bash
docker-compose up -d
```