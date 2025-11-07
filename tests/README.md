# Test Suite Documentation

## Overview

Comprehensive test suite for the portfolio website using Vitest and React Testing Library.

## Test Statistics

- **Total Tests:** 34
- **Test Files:** 5
- **Pass Rate:** 100%
- **Coverage:** Component rendering, user interactions, data validation

## Test Files

### 1. `ThemeToggle.test.jsx` (3 tests)

Tests the dark/light theme toggle functionality:

- ✅ Renders theme toggle button
- ✅ Shows correct mode text
- ✅ Has proper accessibility attributes

### 2. `ProjectCard.test.jsx` (7 tests)

Tests project card component rendering and behavior:

- ✅ Renders project title
- ✅ Renders project summary
- ✅ Renders project tags
- ✅ Links to correct project detail page
- ✅ Renders cover image with alt text
- ✅ Uses title as fallback alt text
- ✅ Handles missing cover images

### 3. `ProjectFilter.test.jsx` (7 tests)

Tests project filtering functionality:

- ✅ Renders all projects initially
- ✅ Renders all filter tags
- ✅ "All" filter active by default
- ✅ Filters projects by tag
- ✅ Shows all projects when "All" clicked
- ✅ Updates active filter styling
- ✅ Handles projects without tags

### 4. `ContactForm.test.jsx` (8 tests)

Tests contact form functionality and security:

- ✅ Renders all form fields
- ✅ Renders submit button
- ✅ Includes honeypot field for spam protection
- ✅ Shows loading state when submitting
- ✅ Shows success message on successful submission
- ✅ Shows error message on failed submission
- ✅ Validates email field
- ✅ All fields are required

### 5. `projects.data.test.js` (9 tests)

Validates project data integrity:

- ✅ Projects data is valid array
- ✅ Each project has required fields
- ✅ Project slugs are unique
- ✅ Project slugs are URL-safe
- ✅ Project tags are arrays
- ✅ Project titles are not empty
- ✅ Project summaries are reasonable length
- ✅ Project cover images are valid URLs
- ✅ Project links are valid URLs when present

## Running Tests

```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:ui

# Run tests once (CI mode)
npm run test:run

# Run with coverage
npm run test:coverage
```

## Test Configuration

### Setup (`tests/setup.js`)

Global test environment setup including:

- `@testing-library/jest-dom` matchers
- `window.matchMedia` mock for theme detection
- `IntersectionObserver` mock for Framer Motion
- `localStorage` mock for theme persistence

### Vitest Config (`vitest.config.js`)

```javascript
{
  environment: 'jsdom',
  globals: true,
  setupFiles: './tests/setup.js'
}
```

## Mocked Browser APIs

The following browser APIs are mocked for testing:

1. **matchMedia** - For theme preference detection
2. **IntersectionObserver** - For Framer Motion animations
3. **localStorage** - For theme persistence
4. **fetch** - For contact form submission

## Writing New Tests

### Component Test Template

```javascript
import { describe, test, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import YourComponent from '../src/components/YourComponent.jsx';

describe('YourComponent', () => {
  test('renders correctly', () => {
    render(<YourComponent />);
    expect(screen.getByText('Expected Text')).toBeInTheDocument();
  });
});
```

### Interaction Test Template

```javascript
import { fireEvent, waitFor } from '@testing-library/react';

test('handles user interaction', async () => {
  render(<YourComponent />);

  const button = screen.getByRole('button');
  fireEvent.click(button);

  await waitFor(() => {
    expect(screen.getByText('Result')).toBeInTheDocument();
  });
});
```

## Best Practices

1. **Use semantic queries** - Prefer `getByRole`, `getByLabelText` over `getByTestId`
2. **Test user behavior** - Focus on what users see and do, not implementation details
3. **Wait for async updates** - Use `waitFor` for animations and state updates
4. **Mock external dependencies** - Mock APIs, browser features, third-party libraries
5. **Keep tests focused** - One assertion per test when possible
6. **Use descriptive test names** - Clearly state what is being tested

## Known Issues & Warnings

### React `act()` Warnings

Some tests show warnings about updates not wrapped in `act()`. These are non-critical and related to
async state updates in form submissions. The tests still pass correctly.

## CI/CD Integration

Tests run automatically on:

- Every push to the repository
- Pull request creation
- Before deployment

### GitHub Actions Workflow

```yaml
- name: Run tests
  run: npm run test:run
```

## Troubleshooting

### Tests failing locally?

1. Clear node_modules and reinstall:

   ```bash
   rm -rf node_modules
   npm install
   ```

2. Clear Vitest cache:
   ```bash
   npx vitest --clearCache
   ```

### Component not rendering?

Check that all required props are provided in the test and that mocks are properly set up in
`tests/setup.js`.

### Async tests timing out?

Increase timeout or check that `waitFor` is used correctly:

```javascript
await waitFor(
  () => {
    expect(element).toBeInTheDocument();
  },
  { timeout: 5000 }
);
```

## Future Enhancements

- [ ] Add E2E tests with Playwright
- [ ] Increase code coverage to 80%+
- [ ] Add performance tests
- [ ] Add accessibility tests (axe-core)
- [ ] Add visual regression tests

---

**Last Updated:** November 7, 2025  
**Test Suite Version:** 1.0.0  
**Framework:** Vitest 4.0.7 + React Testing Library 16.3.0
