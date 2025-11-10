# Local Machine Services

This directory contains Docker Compose configurations for personal/local machine services. These services are designed for personal use and productivity, not necessarily for development purposes.

## 🔒 Security Best Practices

1. **Environment Variables**: Always use `.env` files for sensitive configuration
2. **Secret Keys**: Generate strong, random keys for all services
3. **Network Access**: Most services bind to `localhost` by default. Adjust if needed
4. **Updates**: Regularly update Docker images for security patches

## 🔧 Common Operations

### Starting Services
```bash
cd <service-directory>
docker-compose up -d
```

### Stopping Services
```bash
docker-compose down
```

### Viewing Logs
```bash
docker-compose logs -f
```

### Updating Services
```bash
docker-compose pull
docker-compose up -d
```

### Removing Services (with data)
```bash
docker-compose down -v
```

## 📝 Port Reference

| Service           | Port  | Description             |
| ----------------- | ----- | ----------------------- |
| Glance            | 8008  | Dashboard web interface |
| Open WebUI        | 3000  | AI chat interface       |
| Ollama            | 11434 | LLM API endpoint        |
| Speedtest Tracker | 8433  | Speed test dashboard    |

## 🐛 Troubleshooting

### Port Already in Use
If a port is already in use, either:
- Stop the conflicting service
- Change the port mapping in `docker-compose.yml`

### Permission Issues
For services using volumes, ensure proper permissions:
- Check PUID/PGID in `.env` files
- Verify volume mount paths are accessible

### GPU Not Working (Ollama)
- Verify NVIDIA Docker runtime: `docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi`
- Check GPU is accessible: `nvidia-smi`
- Remove GPU section from `docker-compose.yml` for CPU-only mode

### Services Not Starting
- Check logs: `docker-compose logs <service-name>`
- Verify `.env` file exists and has required variables
- Ensure Docker has sufficient resources (memory, disk space)

## 📚 Additional Resources

- [Glance Documentation](https://github.com/glanceapp/glance)
- [Ollama Documentation](https://ollama.ai/docs)
- [SearXNG Documentation](https://docs.searxng.org/)
- [Open WebUI Documentation](https://docs.openwebui.com/)
- [Speedtest Tracker Documentation](https://github.com/henrywhitaker3/Speedtest-Tracker)

## 💡 Tips

1. **Resource Management**: Ollama with GPU can be resource-intensive. Monitor system resources.
2. **Data Persistence**: All services use Docker volumes. Data persists across container restarts.
3. **Customization**: Each service is highly customizable. Check individual configuration files.
4. **Backup**: Regularly backup volume data if you have important configurations or data.
