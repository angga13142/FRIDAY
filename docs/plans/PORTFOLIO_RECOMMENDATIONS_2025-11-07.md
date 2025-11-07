# Portfolio Recommendations — Muhammad Nurhidayat Gani (2025-11-07)

## Objective

Prioritized improvements to elevate branding, UX, performance, and readiness for hiring managers.

## Top 10 Priorities (Impact → Effort)

1. Content polish (immediate)

- Replace placeholder resume (public/resume.pdf) and photo on About
- Tighten hero copy (one-liner + micro-subtitle)
- Add 1–2 more featured projects with real screenshots

2. Contact form hardening

- Configure Formspree/Web3Forms endpoint
- Add basic honeypot + success/error state messages

3. SEO & social share

- Add head meta (title/description per page)
- Open Graph/Twitter cards + default social image
- JSON-LD Person schema (name, sameAs for GitHub/LinkedIn)

4. Accessibility & focus states

- Visible focus rings, skip-to-content link, ARIA labels on nav
- Color contrast audit for dark/light tokens

5. Animations (measured)

- Use whileInView on islands, IntersectionObserver for static
- Limit motion (reduce motion respect), avoid heavy parallax

6. Performance hardening

- Use Astro <Image> for project images
- Preload fonts (Inter/Manrope), font-display: swap
- Set site in astro.config.mjs (real domain) for canonical links

7. Projects detail depth

- Add MDX per project (story, challenges, metrics, role)
- Gallery component (lightbox optional) with compressed images

8. Navigation quality

- Active link states, scroll-to section IDs
- Header shadow on scroll; small logo mark (MNG) SVG

9. Analytics & monitoring

- Minimal analytics (Plausible/GA4)
- 404 page + link validation script (pre-publish)

10. CI & checks

- ESLint + Prettier minimal; npm run check to include build
- Optional Playwright smoke tests for key flows

## Quick Wins (can ship today)

- Configure Formspree ID, swap resume.pdf + photo
- Add meta OG/Twitter defaults in BaseLayout
- Add skip link & focus styles via Tailwind
- Set site: in astro.config.mjs (e.g., https://muhammadnurhidayatgani.dev)

## Suggested Copy (Hero)

- H1: "Muhammad Nurhidayat Gani"
- Sub: "Membangun Solusi Digital dengan Presisi Struktural."
- Micro: "Dari operator excavator → developer yang berfokus pada struktur, performa, dan UX."

## Lighthouse Targets

- Performance ≥ 95 (desktop), ≥ 90 (mobile)
- Accessibility ≥ 95, Best Practices ≥ 95, SEO ≥ 90

## Optional Enhancements

- PWA (manifest + icons) for installability
- OG image generator (Satori/og.svg) for dynamic social images
- I18n (ID/EN) if dibutuhkan untuk audiens global

## Next Steps

1. Share photo dan resume final → update assets
2. Beri domain/URL produksi untuk config `site`
3. Izin untuk implement Quick Wins (SEO meta, skip link, focus styles)
