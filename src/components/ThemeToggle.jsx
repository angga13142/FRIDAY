import { useEffect, useState } from 'react';
import { motion } from 'framer-motion';

export default function ThemeToggle() {
  const [dark, setDark] = useState(false);
  useEffect(() => {
    const stored = localStorage.getItem('theme');
    if (stored === 'dark' || (!stored && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
      document.documentElement.classList.add('dark');
      setDark(true);
    }
  }, []);
  const toggle = () => {
    const next = !dark;
    setDark(next);
    document.documentElement.classList.toggle('dark', next);
    localStorage.setItem('theme', next ? 'dark' : 'light');
  };
  return (
    <motion.button
      whileTap={{ scale: 0.9 }}
      onClick={toggle}
      aria-label="Toggle theme"
      className="rounded-full border border-black/10 dark:border-white/20 px-3 py-1 text-xs flex items-center gap-2 hover:shadow-card transition bg-white dark:bg-[#1b1b1b]"
    >
      <motion.span
        key={dark ? 'dark' : 'light'}
        initial={{ y: -8, opacity: 0 }}
        animate={{ y: 0, opacity: 1 }}
        exit={{ y: 8, opacity: 0 }}
        className="inline-block"
      >
        {dark ? '🌙 Gelap' : '☀️ Terang'}
      </motion.span>
    </motion.button>
  );
}
