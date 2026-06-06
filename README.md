# 📇 Contact Manager

A full-stack CRUD contact management application built with **FastAPI**, **PostgreSQL**, and **Jinja2 templates**. Dockerized for easy deployment.

## Features

- ✅ Full CRUD operations (Create, Read, Update, Delete)
- 🔍 Search contacts by name, email, company, or role
- 🎨 Color-coded contact avatars
- 📊 Dashboard statistics (total contacts & companies)
- 🐳 Docker & Docker Compose setup
- 🌱 Auto-seeding with sample data on first run
- ❤️ Health check endpoints

## Tech Stack

| Layer     | Technology              |
|-----------|-------------------------|
| Backend   | FastAPI 0.115 + Uvicorn |
| Database  | PostgreSQL 16           |
| ORM       | SQLAlchemy 2.0          |
| Templates | Jinja2                  |
| Styling   | Vanilla CSS             |
| Container | Docker + Docker Compose |

## Prerequisites

- [Docker](https://docs.docker.com/get-docker/) (v20+)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2+)

## Environment Variables

The application requires **4 environment variables** for database connection, plus **3 for PostgreSQL** itself:

### Application (FastAPI)

| Variable  | Description                  | Default          | Required |
|-----------|------------------------------|------------------|----------|
| `DB_HOST` | PostgreSQL host address      | `localhost`      | Yes      |
| `DB_USER` | PostgreSQL username          | `admin`          | Yes      |
| `DB_PASS` | PostgreSQL password          | `secretpass123`  | Yes      |
| `DB_NAME` | PostgreSQL database name     | `crud_app`       | Yes      |

### PostgreSQL Container

| Variable            | Description                         | Default          | Required |
|---------------------|-------------------------------------|------------------|----------|
| `POSTGRES_USER`     | Superuser username for PostgreSQL   | —                | Yes      |
| `POSTGRES_PASSWORD` | Superuser password for PostgreSQL   | —                | Yes      |
| `POSTGRES_DB`       | Database to create on first startup | —                | Yes      |

> **Important:** `DB_USER` / `DB_PASS` / `DB_NAME` on the app side **must match** `POSTGRES_USER` / `POSTGRES_PASSWORD` / `POSTGRES_DB` on the database side.

## Quick Start

### 1. Clone the repository

```bash
git clone <repository-url>
cd <project-directory>
```

### 2. (Optional) Create a `.env` file

If you want to override the default values, create a `.env` file in the project root:

```env
# Database credentials
DB_HOST=db
DB_USER=admin
DB_PASS=your_secure_password
DB_NAME=crud_app

# PostgreSQL container
POSTGRES_USER=admin
POSTGRES_PASSWORD=your_secure_password
POSTGRES_DB=crud_app
```

### 3. Start with Docker Compose

```bash
docker compose up -d
```

This will:
1. Start a PostgreSQL 16 container
2. Build and start the FastAPI application
3. Automatically create the `contacts` table
4. Seed 5 sample contacts if the table is empty

### 4. Access the application

| Service         | URL                                  |
|-----------------|--------------------------------------|
| Web UI          | http://localhost:8000                |
| API Docs (Auto) | http://localhost:8000/docs           |
| Health Check    | http://localhost:8000/health         |
| PostgreSQL      | `localhost:5432` (via database tool) |

## API Reference

| Method   | Endpoint                   | Description              |
|----------|----------------------------|--------------------------|
| `GET`    | `/api/contacts`            | List all contacts        |
| `GET`    | `/api/contacts?search=foo` | Search contacts          |
| `GET`    | `/api/contacts/{id}`       | Get a single contact     |
| `POST`   | `/api/contacts`            | Create a new contact     |
| `PUT`    | `/api/contacts/{id}`       | Update an existing contact |
| `DELETE` | `/api/contacts/{id}`       | Delete a contact         |
| `GET`    | `/api/stats`               | Get dashboard statistics |

## Project Structure

```
.
├── app/
│   ├── main.py              # FastAPI application & routes
│   ├── static/              # CSS, JS, and other static assets
│   └── templates/           # Jinja2 HTML templates
├── docker-compose.yml       # Multi-container orchestration
├── Dockerfile               # Application container image
├── init.sql                 # Database schema reference (not used by Docker)
├── requirements.txt         # Python dependencies
├── .dockerignore            # Files excluded from Docker build context
└── .gitignore               # Files excluded from Git
```

## Development

### Running without Docker

Make sure you have Python 3.12+ and a running PostgreSQL instance, then:

```bash
# Create virtual environment
python -m venv venv
source venv/bin/activate       # Linux/macOS
venv\Scripts\activate          # Windows

# Install dependencies
pip install -r requirements.txt

# Set environment variables
export DB_HOST=localhost
export DB_USER=admin
export DB_PASS=secretpass123
export DB_NAME=crud_app

# Run the development server
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

### Rebuilding the Docker image

```bash
docker compose down
docker compose up -d --build
```

## License

This project is open source and available under the [MIT License](LICENSE).
