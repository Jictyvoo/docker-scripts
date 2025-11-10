# Docker Scripts

This repository contains Docker Compose configurations and scripts for running various services in development and production environments.

## 📁 Project Structure

- **`dev/`**: Development environment scripts and configurations
  - **`databases/`**: Database container scripts (MySQL, PostgreSQL, MongoDB, Redis, SQL Server)
  - **`services/`**: Development service containers (Elasticsearch, Jetty, etc.)
  
- **`prod/`**: Production environment configurations
  - **`redmine/`**: Redmine project management tool
  - **`run-gitlab.sh`**: GitLab CI/CD platform setup script
  - **`yacht-container.sh`**: Yacht container management UI

- **`local_machine_execs/`**: Personal/local machine services
  - **`glance/`**: Glance dashboard for monitoring and widgets
  - **`ollama/`**: Ollama AI stack with SearXNG and Open WebUI
  - **`speedtest/`**: Speedtest Tracker for network monitoring

## 🔒 Security

**Important**: This repository uses environment variables for sensitive data. Never commit `.env` files or files containing passwords.

### Setup Instructions

1. **Copy environment template files**: Each service directory contains a `.env.example` file. Copy it to `.env` and fill in your values:
   ```bash
   cp .env.example .env
   ```

2. **Generate secure secrets**: For services requiring secret keys, generate them using:
   ```bash
   # For 32-character hex strings
   openssl rand -hex 16
   
   # For base64 keys (Speedtest)
   # Use the application's key generation command
   ```

3. **Set strong passwords**: Use strong, unique passwords for all database and service credentials.

### Files to Never Commit

- `.env` files
- `*password*.txt` files
- Any file containing actual credentials

The `.gitignore` file is configured to exclude these automatically.

## 🚀 Quick Start

### Development Databases

Navigate to the database directory and use the provided scripts:

```bash
cd dev/databases
# For MySQL
./mysql-docker.sh

# For PostgreSQL
./postgres-docker.sh

# For MongoDB
./mongodb-container.sh

# For Redis
./redis-container.sh
```

**Note**: Make sure to create a `.env` file in the `dev/databases/` directory with your database credentials before running the scripts.

### Production Services

#### Redmine

```bash
cd prod/redmine
cp .env.example .env
# Edit .env with your credentials
docker-compose up -d
```

Access Redmine at `http://localhost:8081`

#### GitLab

```bash
cd prod
# Edit run-gitlab.sh to configure your hostname
./run-gitlab.sh
```

### Local Machine Services

#### Glance Dashboard

```bash
cd local_machine_execs/glance
cp .env.example .env  # Optional, if you need custom env vars
docker-compose up -d
```

Access at `http://localhost:8008`

#### Ollama AI Stack

```bash
cd local_machine_execs/ollama
cp .env.example .env
# Edit .env and set SEARXNG_SECRET
docker-compose up -d
```

Services:
- Ollama: `http://localhost:11434`
- Open WebUI: `http://localhost:3000`
- SearXNG: Internal (port 8888)

#### Speedtest Tracker

```bash
cd local_machine_execs/speedtest
cp .env.example .env
# Edit .env and generate APP_KEY
docker-compose up -d
```

Access at `http://localhost:8433`

## 📝 Requirements

- Docker Engine 20.10+
- Docker Compose 2.0+ (or docker-compose 1.29+)
- For GPU support (Ollama): NVIDIA Docker runtime

## 🔧 Configuration

Each service directory contains:
- `docker-compose.yml`: Service configuration
- `.env.example`: Template for environment variables
- Service-specific documentation in `local_machine_execs/README.md`

## 📚 Additional Documentation

- See `local_machine_execs/README.md` for detailed information about local services
- Check individual service directories for service-specific configuration options

## ⚠️ Important Notes

1. **Data Persistence**: Most services use Docker volumes. Check `docker-compose.yml` files for volume paths.
2. **Port Conflicts**: Ensure ports are not already in use before starting services.
3. **Resource Requirements**: Some services (like Ollama with GPU) require significant system resources.
4. **Network Configuration**: Services in the same `docker-compose.yml` can communicate using service names.

## 🤝 Contributing

When adding new services:
1. Create a `.env.example` file with all required variables
2. Use environment variables in `docker-compose.yml` instead of hardcoded values
3. Update this README with service information
4. Ensure `.gitignore` excludes sensitive files

## 📄 License

See [LICENSE](LICENSE) file for details.
