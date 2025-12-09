# Azure Static Web App Deployment Guide

This guide explains how to deploy your React app to Azure Static Web Apps using Terraform and GitHub Actions.

## Prerequisites

1. **Azure Account** - [Create a free account](https://azure.microsoft.com/free/)
2. **GitHub Account** - Repository for your code
3. **Azure CLI** - [Install Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli)
4. **Terraform** - Version 1.14.1 or compatible

## Architecture

- **Infrastructure as Code**: Terraform manages Azure resources
- **CI/CD**: GitHub Actions automates deployment
- **Hosting**: Azure Static Web Apps (Free tier)

## Setup Instructions

### 1. Create Azure Service Principal

Create a service principal for GitHub Actions to authenticate with Azure:

```bash
az login

# Create service principal with Contributor role
az ad sp create-for-rbac \
  --name "github-actions-my-first-react-app" \
  --role contributor \
  --scopes /subscriptions/<YOUR_SUBSCRIPTION_ID> \
  --sdk-auth
```

This outputs JSON credentials - save them securely.

### 2. Configure GitHub Secrets

Go to your GitHub repository → Settings → Secrets and variables → Actions → New repository secret

Add the following secrets:

- `AZURE_CLIENT_ID` - Application (client) ID from service principal
- `AZURE_CLIENT_SECRET` - Client secret from service principal
- `AZURE_TENANT_ID` - Directory (tenant) ID
- `AZURE_SUBSCRIPTION_ID` - Your Azure subscription ID

### 3. Customize Terraform Variables (Optional)

Copy and customize the example variables file:

```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
```

Edit `terraform.tfvars` to customize:
- Resource group name
- Location (Azure region)
- Static Web App name
- Tags

**Note**: `terraform.tfvars` is git-ignored for security. Variables will use defaults if not specified.

### 4. Local Terraform Testing (Optional)

Test Terraform configuration locally before pushing:

```bash
cd terraform

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Preview changes
terraform plan

# Apply infrastructure (if you want to deploy manually first)
terraform apply
```

Login to Azure CLI first:
```bash
az login
```

### 5. Deploy via GitHub Actions

Push your code to the `main` branch:

```bash
git add .
git commit -m "Add Azure deployment configuration"
git push origin main
```

GitHub Actions will automatically:
1. ✅ Provision Azure infrastructure with Terraform
2. ✅ Build the React application
3. ✅ Deploy to Azure Static Web Apps
4. ✅ Output the deployment URL

### 6. Access Your Deployed App

After successful deployment:

1. Check the GitHub Actions workflow logs for the deployment URL
2. Or find it in Azure Portal → Static Web Apps → Your app → URL
3. Or run: `cd terraform && terraform output static_web_app_default_hostname`

## Project Structure

```
my-first-react-app/
├── .github/
│   └── workflows/
│       └── azure-static-web-apps.yml    # CI/CD pipeline
├── terraform/
│   ├── providers.tf                     # Terraform & provider config
│   ├── variables.tf                     # Input variables
│   ├── main.tf                          # Azure resources
│   ├── outputs.tf                       # Output values
│   ├── terraform.tfvars.example         # Example variables
│   └── .gitignore                       # Terraform gitignore
├── src/                                 # React source code
└── package.json                         # Node.js dependencies
```

## Workflow Explained

### GitHub Actions Workflow

**Trigger**: Push to `main` branch or manual trigger

**Jobs**:

1. **Terraform Job**
   - Formats, validates, and applies Terraform configuration
   - Creates/updates Azure Static Web App
   - Outputs deployment token for next job

2. **Build and Deploy Job**
   - Installs Node.js dependencies
   - Runs linting
   - Builds React app (`npm run build`)
   - Deploys to Azure Static Web Apps

3. **Close Pull Request Job**
   - Removes preview environments when PRs are closed

### Terraform Configuration

**Resources Created**:
- Resource Group (container for resources)
- Static Web App (Free tier)

**Best Practices Implemented**:
- ✅ Version pinning for reproducibility
- ✅ Organized file structure
- ✅ Input variables for flexibility
- ✅ Output values for integration
- ✅ Sensitive output protection
- ✅ Resource tagging
- ✅ .gitignore for security

## Monitoring & Management

### View Deployment Status

```bash
# In Azure Portal
Azure Portal → Static Web Apps → swa-my-first-react-app

# Using Azure CLI
az staticwebapp show \
  --name swa-my-first-react-app \
  --resource-group rg-my-first-react-app
```

### View Terraform State

```bash
cd terraform
terraform show
```

### Update Infrastructure

Modify Terraform files and push to trigger update:

```bash
# Example: Update tags
cd terraform
# Edit main.tf or variables.tf
git commit -am "Update infrastructure tags"
git push origin main
```

## Troubleshooting

### Deployment Fails

1. Check GitHub Actions logs for detailed error messages
2. Verify all GitHub secrets are set correctly
3. Ensure service principal has proper permissions
4. Check Azure subscription limits (Free tier)

### Terraform Errors

```bash
# Reinitialize Terraform
cd terraform
terraform init -upgrade

# Check state
terraform state list

# Format code
terraform fmt -recursive
```

### Build Errors

```bash
# Test build locally
npm install
npm run build

# Check for errors
npm run lint
```

## Cost Management

**Free Tier Includes**:
- 100 GB bandwidth/month
- Custom domains
- Free SSL certificates
- Automatic HTTPS

**Note**: This configuration uses Azure's Free tier. Monitor usage in Azure Portal.

## Cleanup

To destroy all Azure resources:

```bash
cd terraform
terraform destroy
```

Or via Azure Portal:
1. Go to Resource Groups
2. Select `rg-my-first-react-app`
3. Click "Delete resource group"

## Additional Resources

- [Azure Static Web Apps Documentation](https://docs.microsoft.com/azure/static-web-apps/)
- [Terraform AzureRM Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [GitHub Actions Documentation](https://docs.github.com/actions)
- [Vite Documentation](https://vitejs.dev/)

## Security Notes

- Never commit `terraform.tfvars` or any file with secrets
- Rotate service principal secrets regularly
- Use Azure Key Vault for production secrets
- Review and approve Terraform plans before applying
- Enable branch protection rules on `main` branch

## Next Steps

- [ ] Set up custom domain
- [ ] Configure environment variables
- [ ] Add API backend (Azure Functions)
- [ ] Set up staging environment
- [ ] Configure monitoring and alerts
- [ ] Implement automated testing
