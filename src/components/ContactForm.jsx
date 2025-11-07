import { useState } from 'react';

export default function ContactForm() {
  const [status, setStatus] = useState('');
  const [loading, setLoading] = useState(false);

  async function handleSubmit(e) {
    e.preventDefault();
    setLoading(true);
    setStatus('');

    const form = e.target;
    const data = new FormData(form);

    // Honeypot check
    if (data.get('_gotcha')) {
      setStatus('');
      setLoading(false);
      return;
    }

    try {
      const res = await fetch(form.action, {
        method: 'POST',
        body: data,
        headers: { Accept: 'application/json' }
      });

      if (res.ok) {
        setStatus('✅ Pesan berhasil dikirim! Terima kasih.');
        form.reset();
      } else {
        setStatus('❌ Gagal mengirim pesan. Silakan coba lagi.');
      }
    } catch (err) {
      setStatus('❌ Terjadi kesalahan. Silakan coba lagi.');
    } finally {
      setLoading(false);
    }
  }

  return (
    <form
      action="https://formspree.io/f/your-id"
      method="POST"
      onSubmit={handleSubmit}
      className="space-y-4 mb-12"
      aria-describedby="form-status"
    >
      <input type="text" name="_gotcha" className="hidden" tabIndex="-1" aria-hidden="true" />
      <div>
        <label className="block text-xs font-semibold mb-1" htmlFor="name">
          Nama
        </label>
        <input
          id="name"
          name="name"
          required
          className="w-full rounded border border-black/10 dark:border-white/20 bg-white dark:bg-[#1b1b1b] px-3 py-2 text-sm"
        />
      </div>
      <div>
        <label className="block text-xs font-semibold mb-1" htmlFor="email">
          Email
        </label>
        <input
          id="email"
          name="email"
          type="email"
          required
          className="w-full rounded border border-black/10 dark:border-white/20 bg-white dark:bg-[#1b1b1b] px-3 py-2 text-sm"
        />
      </div>
      <div>
        <label className="block text-xs font-semibold mb-1" htmlFor="message">
          Pesan
        </label>
        <textarea
          id="message"
          name="message"
          rows="5"
          required
          className="w-full rounded border border-black/10 dark:border-white/20 bg-white dark:bg-[#1b1b1b] px-3 py-2 text-sm"
        ></textarea>
      </div>
      <button
        disabled={loading}
        className="px-5 py-3 bg-accent text-white rounded-lg text-sm font-medium hover:shadow-card transition disabled:opacity-50"
      >
        {loading ? 'Mengirim...' : 'Kirim'}
      </button>
      {status && (
        <p id="form-status" className="text-xs mt-2" aria-live="polite">
          {status}
        </p>
      )}
    </form>
  );
}
