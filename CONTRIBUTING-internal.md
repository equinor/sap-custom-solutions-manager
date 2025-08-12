# Contributing to the Internal Web Application

## Overview
This document outlines how to develop features for our internal web application in this private repository (`your-org/internal-app`) while contributing to the public open-source repository (`your-org/open-source-app`). The goal is to maintain enterprise-specific customizations securely and selectively share generic improvements with the open-source community.

## Repository Setup
- **Public Repository**: `your-org/open-source-app` hosts the core application for community use.
- **Private Repository**: This repository (`your-org/internal-app`) contains the open-source codebase plus enterprise-specific features.
- **Initial Setup**:
  - The private repository is initialized with the public repository’s codebase.
  - Add the public repository as an upstream remote:
    ```bash
    git remote add upstream https://github.com/your-org/open-source-app.git
    ```
- **Branching**:
  - Mirror `main` (stable) and `develop` (integration) branches from the public repository.
  - Create enterprise-specific branches (e.g., `enterprise/custom-feature`) for internal development.

## Development Workflow
### 1. Internal Development
- Develop enterprise-specific features or configurations on dedicated branches (e.g., `enterprise/feature-x`).
- Create pull requests (PRs) to merge changes into the private `develop` or `main` branch after team review.
- Regularly sync with the public repository to incorporate community updates:
  ```bash
  git fetch upstream
  git checkout main
  git merge upstream/main
  git push origin main
  ```
- Resolve merge conflicts carefully to preserve enterprise-specific code.

### 2. Contributing to Open Source
- **Identify Contributions**:
  - Determine which internal changes (e.g., bug fixes, generic features) are suitable for the open-source project.
- **Prepare Contribution**:
  - Create a branch (e.g., `open-source/feature-y`) based on the latest `upstream/develop`.
  - Cherry-pick or manually port relevant commits:
    ```bash
    git cherry-pick <commit-hash>
    ```
  - Ensure no sensitive data (e.g., API keys, internal URLs) is included. Use tools like `git-secrets` or `truffleHog` to scan commits.
- **Submit Contribution**:
  - Push the branch to the public repository:
    ```bash
    git push origin open-source/feature-y
    ```
  - Create a PR to `your-org/open-source-app`’s `develop` branch, following its contribution guidelines.
- **Review and Merge**:
  - Engage with community feedback on the PR.
  - Once approved, the changes merge into the public repository and can be synced back to this private repository.

### 3. Incorporating Community Changes
- When community PRs are merged into `your-org/open-source-app`’s `develop` or `main`, sync them to this repository as shown above.
- Test community changes in the internal environment to ensure compatibility with enterprise features.

## Best Practices
- **Code Quality**:
  - Follow the public repository’s coding standards for contributions.
  - Use GitHub Actions for automated testing and linting in this repository.
- **Security**:
  - Never commit sensitive information (e.g., credentials, internal configs).
  - Use Dependabot to keep dependencies updated.
- **Documentation**:
  - Document enterprise-specific features in this repository’s `README.md` or wiki.
  - Refer to `your-org/open-source-app`’s `CONTRIBUTING.md` for public contribution guidelines.
- **Branch Protection**:
  - Enable branch protection for `main` and `develop` to require PRs and reviews.
- **Release Management**:
  - Tag internal releases with a suffix (e.g., `v1.0.0-internal.1`) to differentiate from public releases.
  - Deploy from this repository for internal use.

## Example Workflow
1. Develop a custom feature in `enterprise/custom-report`.
2. Identify a generic bug fix in `enterprise/custom-report` suitable for open source.
3. Create `open-source/bug-fix` branch, cherry-pick relevant commits, and push to `your-org/open-source-app`.
4. Submit a PR to the public repository’s `develop` branch.
5. Sync community updates from `upstream/main` to this repository’s `main`.

## Tools
- **GitHub Actions**: For CI/CD pipelines.
- **Dependabot**: For dependency updates.
- **git-secrets/truffleHog**: To prevent sensitive data leaks.

For questions, contact the internal development team or refer to the public repository’s documentation.