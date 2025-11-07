import { describe, test, expect, vi } from 'vitest';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import ContactForm from '../src/components/ContactForm.jsx';

describe('ContactForm', () => {
  test('renders all form fields', () => {
    render(<ContactForm />);
    expect(screen.getByLabelText(/nama/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/email/i)).toBeInTheDocument();
    expect(screen.getByLabelText(/pesan/i)).toBeInTheDocument();
  });

  test('renders submit button', () => {
    render(<ContactForm />);
    expect(screen.getByRole('button', { name: /kirim/i })).toBeInTheDocument();
  });

  test('includes honeypot field for spam protection', () => {
    render(<ContactForm />);
    const honeypot = screen.getByRole('textbox', { name: '', hidden: true });
    expect(honeypot).toHaveAttribute('name', '_gotcha');
    expect(honeypot).toHaveClass('hidden');
  });

  test('shows loading state when submitting', async () => {
    global.fetch = vi.fn(() =>
      Promise.resolve({
        ok: true,
        json: () => Promise.resolve({}),
      })
    );

    render(<ContactForm />);
    
    const nameInput = screen.getByLabelText(/nama/i);
    const emailInput = screen.getByLabelText(/email/i);
    const messageInput = screen.getByLabelText(/pesan/i);
    const submitButton = screen.getByRole('button', { name: /kirim/i });

    fireEvent.change(nameInput, { target: { value: 'Test User' } });
    fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
    fireEvent.change(messageInput, { target: { value: 'Test message' } });

    fireEvent.click(submitButton);

    expect(screen.getByText(/mengirim/i)).toBeInTheDocument();
  });

  test('shows success message on successful submission', async () => {
    global.fetch = vi.fn(() =>
      Promise.resolve({
        ok: true,
        json: () => Promise.resolve({}),
      })
    );

    render(<ContactForm />);
    
    const nameInput = screen.getByLabelText(/nama/i);
    const emailInput = screen.getByLabelText(/email/i);
    const messageInput = screen.getByLabelText(/pesan/i);
    const submitButton = screen.getByRole('button', { name: /kirim/i });

    fireEvent.change(nameInput, { target: { value: 'Test User' } });
    fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
    fireEvent.change(messageInput, { target: { value: 'Test message' } });

    fireEvent.click(submitButton);

    await waitFor(() => {
      expect(screen.getByText(/berhasil/i)).toBeInTheDocument();
    });
  });

  test('shows error message on failed submission', async () => {
    global.fetch = vi.fn(() =>
      Promise.resolve({
        ok: false,
        json: () => Promise.resolve({}),
      })
    );

    render(<ContactForm />);
    
    const nameInput = screen.getByLabelText(/nama/i);
    const emailInput = screen.getByLabelText(/email/i);
    const messageInput = screen.getByLabelText(/pesan/i);
    const submitButton = screen.getByRole('button', { name: /kirim/i });

    fireEvent.change(nameInput, { target: { value: 'Test User' } });
    fireEvent.change(emailInput, { target: { value: 'test@example.com' } });
    fireEvent.change(messageInput, { target: { value: 'Test message' } });

    fireEvent.click(submitButton);

    await waitFor(() => {
      expect(screen.getByText(/gagal/i)).toBeInTheDocument();
    });
  });

  test('validates email field', () => {
    render(<ContactForm />);
    const emailInput = screen.getByLabelText(/email/i);
    expect(emailInput).toHaveAttribute('type', 'email');
    expect(emailInput).toBeRequired();
  });

  test('all fields are required', () => {
    render(<ContactForm />);
    expect(screen.getByLabelText(/nama/i)).toBeRequired();
    expect(screen.getByLabelText(/email/i)).toBeRequired();
    expect(screen.getByLabelText(/pesan/i)).toBeRequired();
  });
});
