# Contributing to {{PROJECT_NAME}}

Thank you for considering contributing to {{PROJECT_NAME}}! We welcome contributions from everyone.

## How Can I Contribute?

### Reporting Bugs

Before creating bug reports, please check existing issues. When creating a bug report, include:

- **Clear title and description**
- **Steps to reproduce**
- **Expected vs actual behavior**
- **Environment details** (OS, {{PRIMARY_LANGUAGE}} version, etc.)
- **Screenshots** (if applicable)

### Suggesting Enhancements

Enhancement suggestions are welcome! Please provide:

- **Clear use case**
- **Why this enhancement would be useful**
- **Possible implementation approach**

### Pull Requests

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Follow coding standards** (see below)
4. **Write/update tests** (maintain >80% coverage)
5. **Update documentation**
6. **Run tests & linting** (`npm test && npm run lint`)
7. **Commit with conventional commits** (see below)
8. **Push to your fork** (`git push origin feature/amazing-feature`)
9. **Open a Pull Request**

## Coding Standards

### Code Style

- Follow the existing code style
- Use Prettier for formatting (runs on save if configured)
- Follow ESLint rules (0 errors required)
- Write clear, self-documenting code
- Add comments for complex logic

### Commit Messages

We use [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style (formatting, missing semi-colons, etc)
- `refactor`: Code change that neither fixes a bug nor adds a feature
- `perf`: Performance improvement
- `test`: Adding or updating tests
- `chore`: Changes to build process or auxiliary tools

**Examples:**

```
feat(auth): add JWT authentication
fix(api): resolve null pointer exception in user service
docs(readme): update installation instructions
test(user): add unit tests for user model
```

### Testing

- Write tests for all new features
- Maintain test coverage >80%
- Use descriptive test names
- Follow AAA pattern: Arrange, Act, Assert
- Mock external dependencies

### Documentation

- Update README.md if adding features
- Update CHANGELOG.md with changes
- Add JSDoc/docstrings to functions
- Update .github/memory/ after major changes

## Development Setup

```bash
# Clone your fork
git clone https://github.com/YOUR_USERNAME/{{PROJECT_NAME}}.git

# Install dependencies
npm install  # or pip install -r requirements.txt

# Run tests
npm test

# Run linter
npm run lint

# Start development
npm run dev
```

## Project Structure

```
{{PROJECT_NAME}}/
├── src/              # Source code
├── tests/            # Test suites
├── docs/             # Documentation
├── .github/          # GitHub config & AI instructions
└── scripts/          # Build/deploy scripts
```

## Code Review Process

1. **Automated checks must pass** (tests, linting)
2. **At least one approval** from maintainer
3. **Address review comments**
4. **Squash commits** before merge (if requested)
5. **Delete branch** after merge

## Getting Help

- **Questions?** Open a discussion in GitHub Discussions
- **Stuck?** Check existing issues or create a new one
- **Security issues?** See SECURITY.md (do NOT open public issue)

## Recognition

Contributors will be recognized in:

- README.md contributors section
- Release notes
- Project credits

Thank you for contributing! 🎉
