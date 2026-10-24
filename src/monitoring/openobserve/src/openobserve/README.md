# 📊 OpenObserve Service

A modular Docker Compose configuration system for OpenObserve observability platform with support for multiple environments and simplified configuration.

## 🏗️ Project Structure

```sh
src/openobserve/
├── components/                              # Source compose components
│   ├── base/                               # Base components
│   │   ├── docker-compose.yml              # Main OpenObserve service
│   │   └── .env.example                    # Base environment variables
│   ├── environments/                       # Environment components
│   │   ├── devcontainer/
│   │   │   └── docker-compose.yml          # DevContainer environment
│   │   ├── forwarding/
│   │   │   └── docker-compose.yml          # Development with port forwarding
│   │   ├── letsencrypt/
│   │   │   ├── docker-compose.yml          # Let's Encrypt SSL
│   │   │   └── .env.example                # Let's Encrypt variables
│   │   └── step-ca/
│   │       ├── docker-compose.yml          # Step CA SSL
│   │       └── .env.example                # Step CA variables
│   └── extensions/                         # Extension components
│       └── step-ca-trust/                  # Step CA trust extension
│           ├── docker-compose.yml          # Step CA trust configuration
│           └── .env.example                # Step CA trust variables
├── build/                        # Generated configurations (auto-generated)
│   ├── devcontainer/
│   │   ├── base/                 # DevContainer + base
│   │   └── step-ca-trust/        # DevContainer + step-ca-trust
│   ├── forwarding/
│   │   ├── base/                 # Development + base
│   │   └── step-ca-trust/        # Development + step-ca-trust
│   ├── letsencrypt/
│   │   ├── base/                 # Let's Encrypt + base
│   │   └── step-ca-trust/        # Let's Encrypt + step-ca-trust
│   └── step-ca/
│       ├── base/                 # Step CA + base
│       └── step-ca-trust/        # Step CA + step-ca-trust
├── build.sh                      # Build script
└── README.md                     # This file
```

## 🚀 Quick Start

### 1. Build Configurations

Run the build script to generate all possible combinations:

```bash
./build.sh
```

This will create all combinations in the `build/` directory.

### 2. Choose Your Configuration

Navigate to the desired configuration directory:

```bash
# For development with port forwarding
cd build/forwarding/base/

# For DevContainer environment
cd build/devcontainer/base/

# For production with Let's Encrypt SSL
cd build/letsencrypt/base/

# For production with Step CA SSL
cd build/step-ca/base/
```

### 3. Configure Environment

Copy and edit the environment file:

```bash
cp .env.example .env
# Edit .env with your values
```

### 4. Deploy

Start the services:

```bash
docker-compose up -d
```

Access: `http://localhost:5080` (for forwarding mode)

## 🔧 Available Configurations

### Environments

- **devcontainer**: Development environment with workspace network
- **forwarding**: Development environment with port forwarding (5080:5080)
- **letsencrypt**: Production with Let's Encrypt SSL certificates
- **step-ca**: Production with Step CA SSL certificates

### Extensions

- **step-ca-trust**: Adds Step CA trust configuration for secure certificate handling

### Available Configurations

**Base configurations:**

- `devcontainer/base` - DevContainer development setup
- `forwarding/base` - Development with port forwarding
- `letsencrypt/base` - Production with Let's Encrypt SSL
- `step-ca/base` - Production with Step CA SSL

**With extensions:**

- `devcontainer/step-ca-trust` - DevContainer with Step CA trust
- `forwarding/step-ca-trust` - Development with Step CA trust
- `letsencrypt/step-ca-trust` - Let's Encrypt with Step CA trust
- `step-ca/step-ca-trust` - Step CA with trust configuration

## 🔧 Environment Variables

### Base Configuration

- `COMPOSE_PROJECT_NAME`: Project name for Docker Compose (default: openobserve)
- `ZO_ROOT_USER_EMAIL`: Root user email for OpenObserve
- `ZO_ROOT_USER_PASSWORD`: Root user password for OpenObserve

### Let's Encrypt Configuration

- `VIRTUAL_PORT`: Port for nginx-proxy (default: 5080)
- `VIRTUAL_HOST`: Domain for nginx-proxy
- `LETSENCRYPT_HOST`: Domain for SSL certificate
- `LETSENCRYPT_EMAIL`: Email for certificate registration

### Step CA Configuration

- `VIRTUAL_PORT`: Port for nginx-proxy (default: 5080)
- `VIRTUAL_HOST`: Domain for nginx-proxy
- `LETSENCRYPT_HOST`: Domain for SSL certificate
- `LETSENCRYPT_EMAIL`: Email for certificate registration

### Step CA Trust Extension

- `STEP_CA_TRUST`: Enable Step CA trust (default: true)
- `STEP_CA_TRUST_RESTART`: Restart on trust changes (default: true)

## 🐳 Docker Images

OpenObserve provides two Docker images:

- **OSS (Open Source)**: `public.ecr.aws/zinclabs/openobserve:latest` - Free and open source version
- **Enterprise**: `public.ecr.aws/zinclabs/openobserve-enterprise:latest` - Enterprise version with additional features

By default, this configuration uses the OSS image. To use the Enterprise image, modify the `image` field in [`components/base/docker-compose.yml`](components/base/docker-compose.yml).

## 🔐 Authentication

OpenObserve uses built-in authentication with configurable root user credentials.

## 🛠️ Development

### Adding New Environments

1. Create directory in `components/environments/` with `docker-compose.yml` and optional `.env.example` file
2. Run `./build.sh` to generate new combinations

### Adding New Extensions

1. Create directory in `components/extensions/` with `docker-compose.yml` and optional `.env.example` file
2. Run `./build.sh` to generate new combinations with all environments

### Modifying Existing Components

1. Edit the component files in `components/`
2. Run `./build.sh` to regenerate configurations
3. The `build/` directory will be completely recreated

## 🆘 Troubleshooting

**Build Issues:**

- Ensure `yq` is installed: <https://github.com/mikefarah/yq#install>
- Check component file syntax
- Verify all required files exist

**OpenObserve Issues:**

- Check environment variables configuration
- Verify data volume permissions
- Review container logs: `docker logs openobserve`
- Check network connectivity

**SSL Issues:**

- **Let's Encrypt**: Verify domain DNS and letsencrypt-manager
- **Step CA**: Check step-ca-manager and virtual network config

## 📝 Notes

- The `build/` directory is automatically generated and should not be edited manually
- Environment variables in generated files use `$VARIABLE_NAME` format for proper interpolation
- Each generated configuration includes a complete `docker-compose.yml` and `.env.example`
- OpenObserve data is persisted in named Docker volumes

## 🔄 Configuration Management

The build system automatically:

- Merges base and environment configurations
- Copies additional files and configurations
- Generates complete deployment configurations
- Preserves user `.env` files during rebuilds

**Build approach:**

```bash
./build.sh
cd build/forwarding/base/
cp .env.example .env
# Edit .env with your values
docker-compose up -d
```
