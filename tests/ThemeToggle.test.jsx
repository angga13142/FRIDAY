import { describe, test, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import ThemeToggle from '../src/components/ThemeToggle.jsx';

describe('ThemeToggle', () => {
  test('renders theme toggle button', () => {
    render(<ThemeToggle />);
    const button = screen.getByRole('button', { name: /toggle theme/i });
    expect(button).toBeInTheDocument();
  });

  test('shows light mode text initially', () => {
    render(<ThemeToggle />);
    expect(screen.getByText(/terang/i)).toBeInTheDocument();
  });

  test('button has proper accessibility attributes', () => {
    render(<ThemeToggle />);
    const button = screen.getByRole('button');
    expect(button).toHaveAttribute('aria-label', 'Toggle theme');
  });
});
