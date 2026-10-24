# 📊 OpenObserve Stack

Complete Docker-based OpenObserve deployment with SSL certificate management for production and development environments.

## 🧩 Components

### 🔐 SSL Automation

#### [🔒 Let's Encrypt Manager](src/ssl-automation/letsencrypt-manager)

Automatic SSL certificate management from Let's Encrypt for production deployments. Provides seamless HTTPS integration for Docker containers using nginx-proxy and acme-companion.
[Learn more about Let's Encrypt Manager configuration](src/ssl-automation/letsencrypt-manager/README.md).

#### [🏠 Step CA Manager](src/ssl-automation/step-ca-manager)

Local domain stack with trusted self-signed certificates for virtual network deployments. Includes private CA management and local DNS resolution for development environments.
[Learn more about Step CA Manager configuration](src/ssl-automation/step-ca-manager/README.md).

### 📊 Observability Services

#### [📈 OpenObserve](src/openobserve)

Cloud-native observability platform providing logs, metrics, and traces in a single unified interface. Includes modular Docker Compose configuration system with support for multiple environments and simplified configuration.
[Learn more about OpenObserve configuration](src/openobserve/README.md).

## 🚀 Quick Start

Each component has its own README with detailed setup instructions. Choose the certificate management solution that fits your deployment scenario.

### Basic Setup

1. **Choose SSL Management:**
   - Production: Use Let's Encrypt Manager
   - Development: Use Step CA Manager

2. **Deploy OpenObserve:**
   - Set up OpenObserve observability platform

## 🏗️ Architecture

```sh
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   OpenObserve   │────│   Data Storage  │────│   SSL Manager   │
│  (Observability)│    │   (Persistent)  │    │ (Let's Encrypt/ │
│                 │    │                 │    │  Step CA)       │
└─────────────────┘    └─────────────────┘    └─────────────────┘
                                │
                                │
                       ┌─────────────────┐
                       │  Log Sources    │
                       │ (Applications,  │
                       │  Infrastructure)│
                       └─────────────────┘
```

## 📋 Requirements

- Docker & Docker Compose
- Domain name (for production deployments)
- Email address (for Let's Encrypt)
- `yq` tool for configuration building

## 🔧 Configuration

All services use modular Docker Compose configurations with:

- **Base components**: Core service definitions
- **Environment components**: Development, production, SSL configurations
- **Build system**: Automatic generation of deployment combinations

## 🌍 Deployment Scenarios

### Development Environment

```bash
# OpenObserve with port forwarding
cd src/openobserve/build/forwarding/base/
docker-compose up -d
```

### Production Environment

```bash
# OpenObserve with Let's Encrypt SSL
cd src/openobserve/build/letsencrypt/base/
docker-compose up -d
```

### DevContainer Environment

```bash
# OpenObserve in DevContainer
cd src/openobserve/build/devcontainer/base/
docker-compose up -d
```

## 🔐 Security Features

- **SSL/TLS Encryption**: Automatic certificate management
- **Data Security**: Secure data storage and transmission
- **Network Isolation**: Docker network segmentation
- **Secret Management**: Environment-based configuration

## 🆘 Troubleshooting

### Common Issues

- **SSL Certificate Issues**: Check Let's Encrypt/Step CA configuration
- **Network Connectivity**: Ensure proper Docker network configuration
- **Data Persistence**: Check volume mounts and permissions

### Logs

```bash
# OpenObserve logs
docker logs openobserve

# SSL automation logs
docker logs letsencrypt-manager  # or step-ca-manager
```

## 📚 Documentation

- [OpenObserve Configuration](src/openobserve/README.md)
- [SSL Automation](src/ssl-automation/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test configurations
5. Submit a pull request

## 📄 License

This project is dual-licensed under:

- [Apache License 2.0](LICENSE-APACHE)
- [MIT License](LICENSE-MIT)

## 🔗 Related Projects

- [OpenObserve](https://openobserve.ai/) - Cloud-native observability platform
- [Zinc Labs](https://zinclabs.io/) - Company behind OpenObserve
- [Let's Encrypt](https://letsencrypt.org/) - Free SSL certificates
- [Step CA](https://smallstep.com/certificates/) - Private certificate authority
