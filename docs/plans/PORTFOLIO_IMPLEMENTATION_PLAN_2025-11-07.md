# Implementation Plan: Personal Portfolio — Muhammad Nurhidayat Gani

Created: 2025-11-07 00:00 UTC Status: Planning Owner: FRIDAY Protocol

## 1) Requirements Analysis

- User problem:
  - Membutuhkan website portofolio modern, cepat, minimalis, dan interaktif untuk personal branding
    yang kuat.
  - Menunjukkan transisi karier dari operator excavator → developer secara meyakinkan.
- Target users:
  - Recruiter/HR, Hiring Manager, Calon klien freelance, Komunitas developer.
- Expected behavior (happy path):
  - Pengunjung memahami profil dalam 5–10 detik (hero + tagline), menelusuri proyek, membaca kisah,
    dan menghubungi via form/CTA.
- Non-goals / out-of-scope:
  - CMS/headless admin panel, blog multi-penulis, backend custom untuk form (pakai layanan pihak
    ketiga).
- Assumptions:
  - Konten teks, foto profesional, dan link sosial tersedia atau dapat disediakan kemudian.
  - Bahasa utama Indonesia (dapat ditambah i18n nanti).

## 2) Success Metrics (KPIs)

- Primary:
  - Bounce rate < 45%, Time on page > 90 detik, Conversion (klik CTA Hubungi/LinkedIn) ≥ 5%.
- Secondary:
  - Performance Lighthouse ≥ 95 (desktop), ≥ 90 (mobile); SEO ≥ 90.
- Guardrails (latency, error rate):
  - TTFB < 200ms (static hosting), error JS fatal = 0.

## 3) Technical Approach

- Architecture impact (handlers/services/router):
  - Framework: Astro.js (SSG). Interaktivitas via React sebagai Astro Islands.
  - Styling: Tailwind CSS. Animasi: Framer Motion (komponen React) + CSS transitions untuk efek
    ringan.
  - Routing file-based Astro: pages `index.astro`, `about.astro`, `projects.astro`,
    `projects/[slug].astro`, `contact.astro`.
- Data model/storage changes:
  - Sumber data proyek: `src/data/projects.json` (list ringkas) + optional detail per proyek di
    `src/content/projects/[slug].mdx` (opsional tahap 2).
- External dependencies (APIs, SDKs):
  - Formspree/Web3Forms untuk submission form kontak.
  - Google Fonts (Inter atau Manrope) via CSS import atau @next/font alternatif.
- Config/feature flags:
  - Mode gelap/terang via `class` strategy (Tailwind `dark` class), persist dengan localStorage.
- Security/PII considerations:
  - Validasi form di client-side (HTML5 + sanitasi minimal). Tidak menyimpan data pribadi di repo.
- Monitoring/observability (logs, metrics, alerts):
  - Integrasi sederhana: Google Analytics (opsional). Netlify/Vercel analytics (opsional). Konsol
    error minimal.
- Rollout strategy (flag, gradual, A/B):
  - Deploy staging (preview) → review → production. Fitur opsional (MDX detail) diaktifkan tahap 2.
- Backout plan:
  - Rollback ke build sebelumnya melalui platform hosting (Vercel/Netlify). Kode bersifat statis,
    risiko rendah.

## 4) File List (create/modify)

- [ ] package.json — project manifest (Astro + React + Tailwind + Framer Motion)
- [ ] astro.config.mjs — konfigurasi Astro (integrations: react, mdx (opsional))
- [ ] tailwind.config.cjs — tema (light/dark), warna aksen, font
- [ ] postcss.config.cjs — PostCSS config
- [ ] src/styles/global.css — import Tailwind base/components/utilities
- [ ] src/layouts/BaseLayout.astro — layout global (header sticky, footer)
- [ ] src/components/Header.astro — navigasi sticky + toggle tema
- [ ] src/components/ThemeToggle.jsx — tombol mode terang/gelap (persist)
- [ ] src/components/ProjectCard.jsx — kartu proyek (hover, framer-motion masuk viewport)
- [ ] src/components/ProjectFilter.jsx — filter proyek (React + Framer Motion)
- [ ] src/pages/index.astro — hero, proyek unggulan, intro, CTA
- [ ] src/pages/about.astro — foto, narasi transisi, keahlian
- [ ] src/pages/projects.astro — grid + filter
- [ ] src/pages/projects/[slug].astro — detail proyek (dynamic)
- [ ] src/pages/contact.astro — form kontak + social links
- [ ] src/data/projects.json — data proyek ringkas (slug, title, summary, tags, links, cover)
- [ ] public/resume.pdf — file resume untuk unduh (atau URL eksternal)
- [ ] public/favicon.svg — ikon
- [ ] README.md — cara run & deploy

## 5) Risks & Mitigations

- Risiko: Animasi berlebihan menurunkan performa → Mitigasi: gunakan motion yang ringan, prefer CSS;
  batasi parallax.
- Risiko: Inkonistensi tema dark/light → Mitigasi: tokenisasi warna di Tailwind, uji kontras.
- Risiko: Konten belum lengkap → Mitigasi: placeholder + checklist pengisian; rilis iteratif.
- Risiko: CI/CD file-size limit (>700 lines) → Mitigasi: komponen terpisah, modularisasi.
- Risiko: Secrets/keys terekspos → Mitigasi: pakai env untuk analytics/form jika perlu.

## 6) Test Strategy (Jest / Playwright)

- Unit tests (opsional ringan):
  - Utilitas tema (persist/load), rendering dasar komponen React tanpa error.
- Integration/E2E (Playwright, opsional):
  - Halaman utama memuat elemen hero, 3 proyek unggulan.
  - Filter proyek menyaring berdasarkan tag.
  - Navigasi antar halaman bekerja (About, Projects, Contact).
- Edge cases:
  - Tanpa proyek unggulan (fallback UI), gambar gagal load (alt text), form invalid.
- Acceptance criteria (must pass):
  - Desain responsif (mobile-first), toggle tema berfungsi dan persist, animasi scroll halus, hover
    states jelas.
- Non-regression checks (lint 0 errors, tests green):
  - `npm run lint` tanpa error; build Astro sukses; jika E2E diaktifkan, semua pass.

---

## Content & Design Specifications

- Branding
  - Nama: Muhammad Nurhidayat Gani
  - Tagline: "Membangun Solusi Digital dengan Presisi Struktural."
  - Kisah: Transisi dari operator excavator profesional menjadi developer (narasi About).
- Desain (referensi: noomoagency.com & igloo.inc)
  - Whitespace luas, grid ketat.
  - Light: bg #FFFFFF/#F9F9F9, text #111111, aksen #3A7DFF (Biru Elektrik)
  - Dark: bg #111111, text #EAEAEA, aksen #3A7DFF
  - Font: Inter atau Manrope (heading bold; body regular)
  - Navigasi: header sticky, logo kiri, menu kanan (Beranda, Tentang Saya, Proyek, Kontak)

## Data: Projects (sample)

File: `src/data/projects.json`

```json
[
  {
    "slug": "whatsapp-shopping-chatbot",
    "title": "WhatsApp Shopping Chatbot Assistant",
    "summary": "Chatbot profesional untuk jualan via WhatsApp dengan AI dan katalog dinamis.",
    "tags": ["Node.js", "AI", "WhatsApp", "E-commerce"],
    "cover": "/images/projects/chatbot-cover.jpg",
    "links": {
      "source": "https://github.com/angga13142/chatbkt",
      "demo": "https://github.com/angga13142/chatbkt"
    }
  },
  {
    "slug": "cryptostock-news-site",
    "title": "Website Berita Finansial",
    "summary": "Portal berita finansial modern dengan fokus crypto & saham.",
    "tags": ["Next.js", "Content", "SEO"],
    "cover": "/images/projects/cryptostock-cover.jpg",
    "links": {
      "demo": "https://cryptostock.dev"
    }
  }
]
```

> Detail proyek lanjutan dapat dipindahkan ke MDX per slug pada tahap 2.

## Page Structure

- index.astro
  - Hero (nama + tagline, animasi teks)
  - Proyek Unggulan (3 item dari data)
  - Intro singkat + tombol ke About
  - CTA "Siap Membangun Sesuatu?" → Contact
- about.astro
  - Foto profesional (URL/FIle), narasi transisi karier
  - Keahlian: Frontend, Backend, Database, Tools (grid/badge)
  - Tombol Unduh Resume (public/resume.pdf)
- projects.astro
  - ProjectFilter.jsx (React + Framer Motion)
  - Grid ProjectCard.jsx (hover elevasi/scale, lazy images)
  - Klik kartu → /projects/[slug]
- projects/[slug].astro
  - Judul, deskripsi, galeri, teknologi, tombol Demo & Source
- contact.astro
  - Form (Nama, Email, Pesan) → Formspree/Web3Forms
  - Tautan sosial: LinkedIn (https://www.linkedin.com/in/mnhidayatgani) & GitHub
    (https://github.com/mnhidayatgani)

## Animations & Interactions

- Scroll-triggered: reveal (fade-in/slide-in) via IntersectionObserver (Astro) atau whileInView
  (Framer Motion) pada islands.
- Hover states: scale-105 + shadow-md + aksen border.
- Theme toggle: spring micro-interaction (Framer Motion) pada tombol.

## How to Run / Validate

- Commands (lint/test/dev):
  - Init: `npm create astro@latest` (template minimal) + add React & Tailwind integrations.
  - Dev: `npm run dev` → open http://localhost:4321
  - Build: `npm run build` → `dist/`
  - Optional E2E: Playwright `npx playwright test`
- Feature flag/env updates:
  - Form endpoint key (Formspree/Web3Forms) via .env (opsional), GA key jika dipakai.
- Manual test steps:
  - Uji responsivitas (mobile/tablet/desktop), toggle tema persist setelah reload, animasi scroll
    mulus, filter proyek berfungsi, form kirim sukses.
- Post-deploy verification & monitoring:
  - Lighthouse score, link sosial valid, form terima email, 404 route tertangani.

## Timeline & Milestones (est.)

- Hari 1: Scaffold proyek, Tailwind + tema, Header, Hero, ThemeToggle.
- Hari 2: ProjectCard + data, halaman Projects + Filter (basic), hover/scroll animasi.
- Hari 3: About + Contact (form), slug detail proyek dasar.
- Hari 4: Polishing UI, aksesibilitas, Lighthouse, deploy preview.
- Hari 5: Revisi konten, optimasi gambar, produksi.
