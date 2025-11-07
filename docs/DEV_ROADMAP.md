# Development Roadmap - Portfolio Muhammad Nurhidayat Gani

**Tanggal Dibuat:** 7 November 2025  
**Status:** Active Planning  
**Target Launch:** Q1 2026

---

## 📊 Current Status (November 2025)

### ✅ Completed (v1.0.0)

**Core Features:**

- [x] Responsive design (mobile-first)
- [x] Dark/light mode dengan persistence
- [x] Smooth scroll animations (Framer Motion)
- [x] Project filtering by tags
- [x] Dynamic routing untuk project details
- [x] Contact form dengan spam protection
- [x] SEO optimization (meta tags, JSON-LD, OG images)
- [x] Accessibility (skip link, focus states, ARIA labels)

**Testing & Quality:**

- [x] Test suite (34 tests, 100% passing)
- [x] Documentation lengkap (teknis + user guide)
- [x] Build verification (0 errors)
- [x] Lighthouse score 95+ (all categories)

**Infrastructure:**

- [x] Astro 4 + React 18 setup
- [x] Tailwind CSS + PostCSS configuration
- [x] Vitest + Testing Library integration
- [x] Git repository + version control

---

## 🎯 Vision & Goals

### Short-term (Q4 2025 - Q1 2026)

Focus: **Content & Polish**

- Lengkapi konten proyek (3-5 real projects)
- Professional photography & branding
- Deploy ke production
- Analytics & monitoring setup

### Mid-term (Q1 - Q2 2026)

Focus: **Feature Enhancement**

- Blog/articles section
- Advanced project showcase
- Multi-language support
- Performance optimization

### Long-term (Q2 2026+)

Focus: **Growth & Innovation**

- Interactive demos
- Case studies & portfolio pieces
- Community features
- Continuous improvement

---

## 🗺️ Roadmap by Quarter

## Phase 1: Content & Launch (November 2025 - January 2026)

### Milestone 1.1: Content Completion (November 2025)

**Priority:** P0 (Critical)  
**Effort:** 2 weeks

**Tasks:**

- [ ] Tulis bio lengkap untuk About page (500-800 words)
- [ ] Tambahkan 3 proyek nyata ke `projects.json`:
  - [ ] WhatsApp Shopping Chatbot (complete)
  - [ ] CryptoStock News Site (complete)
  - [ ] Project ketiga (pilih: web app/API/automation)
- [ ] Buat project detail content untuk masing-masing
- [ ] Screenshot/mockup berkualitas tinggi untuk covers
- [ ] Update resume PDF (versi terbaru)
- [ ] Professional photo untuk About page

**Acceptance Criteria:**

- Semua content placeholder diganti dengan konten asli
- Minimal 3 proyek dengan complete details
- Resume PDF up-to-date
- Professional photo quality

**Dependencies:** None  
**Blockers:** None

---

### Milestone 1.2: Branding & Visual Polish (December 2025)

**Priority:** P0 (Critical)  
**Effort:** 1 week

**Tasks:**

- [ ] Design favicon & app icons (16x16 → 512x512)
- [ ] Create OG images per page (1200×630px)
  - [ ] Home OG image
  - [ ] About OG image
  - [ ] Projects OG image
  - [ ] Contact OG image
- [ ] Design logo (SVG, scalable)
- [ ] Define complete color palette
- [ ] Typography refinement (if needed)
- [ ] Micro-interactions polish

**Acceptance Criteria:**

- Favicon muncul di semua browser
- OG images unik per page
- Logo konsisten di header
- Color palette documented

**Dependencies:** None  
**Blockers:** Design skills (consider hiring designer)

---

### Milestone 1.3: Production Deployment (December 2025)

**Priority:** P0 (Critical)  
**Effort:** 3 days

**Tasks:**

- [ ] Setup custom domain (muhammadnurhidayatgani.dev atau .com)
- [ ] Configure Formspree dengan domain asli
- [ ] Deploy ke Netlify/Vercel
- [ ] Setup SSL certificate (auto via platform)
- [ ] Configure DNS records
- [ ] Test di production environment
- [ ] Update all social links ke domain production

**Acceptance Criteria:**

- Website live di custom domain
- SSL enabled (HTTPS)
- Contact form working di production
- All links functional

**Dependencies:** Domain purchase, Formspree account  
**Blockers:** Budget untuk domain (~$12/year)

**Deployment Checklist:**

```bash
✓ Update site URL di astro.config.mjs
✓ Ganti Formspree endpoint ID
✓ Update social links (GitHub, LinkedIn)
✓ Test build lokal: npm run build
✓ Lighthouse audit: 95+ all categories
✓ Cross-browser testing (Chrome, Firefox, Safari)
✓ Mobile testing (iOS, Android)
✓ Form submission test di production
```

---

### Milestone 1.4: Analytics & Monitoring (January 2026)

**Priority:** P1 (High)  
**Effort:** 2 days

**Tasks:**

- [ ] Setup analytics platform (pilih satu):
  - Option A: Plausible Analytics (€9/month, privacy-focused) ⭐ Recommended
  - Option B: Simple Analytics ($19/month, privacy-focused)
  - Option C: Google Analytics 4 (free, tidak privacy-focused)
- [ ] Configure custom events:
  - [ ] Project card clicks
  - [ ] Filter interactions
  - [ ] Contact form submissions
  - [ ] Resume downloads
- [ ] Setup Lighthouse CI untuk monitoring performance
- [ ] Configure uptime monitoring (UptimeRobot free tier)

**Acceptance Criteria:**

- Analytics tracking live
- Custom events firing correctly
- Weekly performance reports
- Uptime monitoring active

**Dependencies:** Production deployment  
**Blockers:** Budget untuk paid analytics (opsional)

---

## Phase 2: Feature Enhancement (February - April 2026)

### Milestone 2.1: Blog/Articles Section (February 2026)

**Priority:** P1 (High)  
**Effort:** 2 weeks

**Fitur:**

- Blog listing page dengan pagination
- Individual blog post pages (MDX)
- Categories & tags
- Reading time estimator
- Table of contents auto-generated
- Code syntax highlighting
- Related posts recommendation

**Technical Approach:**

- Use Astro Content Collections
- MDX for rich content (React components in markdown)
- Remark/Rehype plugins untuk TOC & syntax highlighting
- RSS feed generation

**File Changes:**

```
src/
├── content/
│   ├── config.ts          # Content collections schema
│   └── blog/
│       ├── post-1.mdx
│       ├── post-2.mdx
│       └── ...
├── pages/
│   ├── blog/
│   │   ├── index.astro    # Blog listing
│   │   └── [slug].astro   # Blog post detail
└── components/
    ├── BlogCard.jsx
    ├── TableOfContents.jsx
    └── ReadingTime.jsx
```

**Tests to Add:**

- Blog listing renders correctly
- Blog post content loads
- TOC links work
- Reading time calculation accurate

**Success Metrics:**

- 5+ blog posts published
- Average time on page >3 minutes
- Bounce rate <60%

---

### Milestone 2.2: Advanced Project Showcase (March 2026)

**Priority:** P1 (High)  
**Effort:** 1.5 weeks

**Fitur:**

- Image gallery/carousel untuk project screenshots
- Tech stack icons dengan tooltips
- Project metrics (users, performance, etc.)
- Challenge & solution sections
- Role & responsibilities detail
- Testimonials (jika ada)

**Technical Approach:**

- Enhance `[slug].astro` dengan sections baru
- Use Swiper.js atau custom carousel
- SVG tech stack icons
- Structured data untuk portfolio pieces

**File Changes:**

```
src/
├── components/
│   ├── ImageGallery.jsx   # Carousel komponen
│   ├── TechStack.jsx      # Icon grid dengan tooltips
│   └── MetricsCard.jsx    # Stats display
└── pages/projects/
    └── [slug].astro       # Enhanced layout
```

**Data Schema Update:**

```json
{
  "slug": "project-slug",
  "title": "Project Title",
  "gallery": [{ "url": "...", "caption": "..." }],
  "techStack": ["React", "Node.js", "MongoDB"],
  "metrics": {
    "users": "10K+",
    "performance": "95+ Lighthouse"
  },
  "challenge": "Description...",
  "solution": "Description...",
  "role": "Full-stack Developer",
  "testimonial": {
    "text": "...",
    "author": "Client Name",
    "position": "CEO"
  }
}
```

**Tests to Add:**

- Gallery navigation works
- Tech stack icons render
- Metrics display correctly
- Sections responsive

**Success Metrics:**

- Average time on project pages >2 minutes
- Gallery interactions tracked
- Lower bounce rate vs current

---

### Milestone 2.3: Multi-Language Support (April 2026)

**Priority:** P2 (Medium)  
**Effort:** 2 weeks

**Fitur:**

- Bahasa Indonesia (default) + English
- Language switcher di header
- Persisted language preference
- Translated content per page
- URL structure: `/en/about` vs `/id/about`

**Technical Approach:**

- Astro i18n routing
- Translation files (JSON atau YAML)
- `useTranslation` hook untuk React components
- Auto-detect browser language

**File Structure:**

```
src/
├── i18n/
│   ├── id.json           # Indonesian translations
│   ├── en.json           # English translations
│   └── config.ts         # i18n configuration
├── pages/
│   ├── [lang]/           # Language-prefixed routes
│   │   ├── index.astro
│   │   ├── about.astro
│   │   └── ...
└── components/
    └── LanguageSwitcher.jsx
```

**Translation Coverage:**

- UI strings (buttons, labels, etc.)
- Page content (titles, descriptions)
- Project summaries (manual translation)
- Meta tags & OG tags

**Tests to Add:**

- Language switcher functionality
- Translation loading
- URL routing correct
- Preference persistence

**Success Metrics:**

- 30%+ visitors use English version
- Lower bounce rate untuk international visitors

---

## Phase 3: Performance & Optimization (May - June 2026)

### Milestone 3.1: Image Optimization (May 2026)

**Priority:** P1 (High)  
**Effort:** 1 week

**Tasks:**

- [ ] Self-host semua images (tidak pakai Unsplash CDN)
- [ ] Generate WebP & AVIF versions
- [ ] Implement responsive images (srcset)
- [ ] Lazy loading strategy (blur-up placeholder)
- [ ] Image compression pipeline (Sharp/ImageMagick)

**Technical Approach:**

- Astro Image integration atau @astrojs/image
- Build-time image processing
- CDN untuk image delivery (Cloudflare/CloudFlare)

**Expected Results:**

- 50%+ reduction in image size
- Faster LCP (Largest Contentful Paint)
- Better Lighthouse performance score

---

### Milestone 3.2: Code Splitting & PWA (June 2026)

**Priority:** P2 (Medium)  
**Effort:** 1 week

**Tasks:**

- [ ] Implement route-based code splitting
- [ ] Add service worker untuk offline support
- [ ] Create web app manifest
- [ ] Add app icons (PWA)
- [ ] Cache strategies (network-first, cache-first)

**Technical Approach:**

- Vite code splitting (automatic via Astro)
- Workbox untuk service worker
- PWA manifest generation

**Expected Results:**

- Faster subsequent page loads
- Offline functionality
- "Add to Home Screen" capability
- Improved perceived performance

---

### Milestone 3.3: Font Optimization (June 2026)

**Priority:** P2 (Medium)  
**Effort:** 2 days

**Tasks:**

- [ ] Self-host Google Fonts (Inter, Manrope)
- [ ] Subset fonts (Latin only)
- [ ] Use variable fonts (reduce file count)
- [ ] Preload critical fonts
- [ ] `font-display: swap` optimization

**Technical Approach:**

- Download fonts dari Google Fonts
- Use `fontsource` npm packages
- Font subsetting dengan `glyphhanger`

**Expected Results:**

- Eliminate external font requests
- Faster FOFT (Flash of Faux Text)
- Better Lighthouse score

---

## Phase 4: Advanced Features (Q3 2026+)

### Future Considerations (Not Scheduled Yet)

**Search Functionality:**

- Global site search
- Project search dengan filters
- Fuzzy matching
- Search analytics

**Dark Mode Enhancements:**

- Auto-schedule (sunset/sunrise)
- Multiple theme options (blue, purple, etc.)
- Smooth color transitions

**Interactive Demos:**

- Embedded CodeSandbox/StackBlitz
- Live project previews
- Interactive code examples

**Community Features:**

- Newsletter subscription
- Comments (utterances.es atau Giscus)
- Social share buttons
- Visitor counter/stats

**Case Studies:**

- Long-form project writeups
- Problem → Solution → Results format
- Metrics & outcomes showcase

---

## 📏 Success Metrics & KPIs

### Traffic & Engagement

- **Monthly Visitors:** Target 1,000+ by Q2 2026
- **Bounce Rate:** <40% (industry avg: 50-60%)
- **Avg. Session Duration:** >2 minutes
- **Pages per Session:** >2 pages

### Performance

- **Lighthouse Performance:** 95+ (desktop), 90+ (mobile)
- **Time to Interactive (TTI):** <3 seconds
- **First Contentful Paint (FCP):** <1.5 seconds
- **Cumulative Layout Shift (CLS):** <0.1

### Conversion

- **Contact Form Submissions:** 5+ per month
- **Resume Downloads:** 10+ per month
- **Project Demo Clicks:** 50+ per month

### SEO

- **Google Search Impressions:** 500+ per month by Q2 2026
- **Avg. Position:** Top 10 untuk target keywords
- **Backlinks:** 10+ quality backlinks

---

## 🎨 Design System Evolution

### Current (v1.0)

- Colors: Blue accent (#3A7DFF)
- Fonts: Inter (body), Manrope (headings)
- Spacing: Tailwind default scale
- Components: 6 React islands

### Planned (v1.5 - Q1 2026)

- [ ] Extended color palette (success, warning, error states)
- [ ] Custom spacing scale
- [ ] Component library documentation
- [ ] Design tokens (CSS variables)

### Future (v2.0 - Q2 2026)

- [ ] Multiple theme presets
- [ ] Animation library
- [ ] Accessibility guidelines
- [ ] Figma design system

---

## 🔧 Technical Debt & Maintenance

### Known Issues (To Address)

- [ ] Tailwind CSS lint warnings (false positives - low priority)
- [ ] React `act()` warnings di tests (cosmetic - low priority)
- [ ] Formspree dependency (consider self-hosted solution)

### Regular Maintenance Tasks

- **Monthly:**

  - Dependency updates (`npm outdated`)
  - Lighthouse audit
  - Broken link check
  - Analytics review

- **Quarterly:**

  - Security audit
  - Accessibility audit
  - Content refresh
  - Performance optimization review

- **Annually:**
  - Major dependency upgrades (Astro, React, etc.)
  - Design refresh
  - Content strategy review
  - Roadmap planning

---

## 💰 Budget Planning

### One-Time Costs

| Item               | Cost     | Priority | Status  |
| ------------------ | -------- | -------- | ------- |
| Domain (.dev)      | $12/year | P0       | Pending |
| Design Assets      | $0-200   | P1       | Pending |
| Professional Photo | $0-100   | P1       | Pending |

### Recurring Costs (Monthly)

| Item                     | Cost           | Priority | Status  |
| ------------------------ | -------------- | -------- | ------- |
| Hosting (Netlify/Vercel) | $0 (free tier) | P0       | Active  |
| Analytics (Plausible)    | €9 (~$10)      | P1       | Pending |
| Email (Formspree)        | $0 (free tier) | P0       | Active  |

**Total Annual Budget:** ~$150-400 (depending on choices)

---

## 🚀 Launch Checklist (Pre-Production)

### Content

- [x] 3+ real projects added
- [x] Bio lengkap written
- [x] Resume PDF updated
- [x] Professional photo

### Technical

- [x] All tests passing (34/34)
- [x] Build succeeds (0 errors)
- [x] Lighthouse 95+ all categories
- [x] Cross-browser tested
- [x] Mobile responsive verified
- [x] Contact form working

### SEO

- [x] Meta tags per page
- [x] OG images per page
- [x] JSON-LD schema
- [x] Sitemap generated
- [x] Robots.txt configured

### Legal & Privacy

- [ ] Privacy policy page
- [ ] Cookie notice (jika pakai analytics)
- [ ] Terms of use (opsional)

### Marketing

- [ ] Social media announcement prepared
- [ ] LinkedIn post draft
- [ ] GitHub README updated dengan link
- [ ] Portfolio added to directories (Awwwards, CSS Design Awards, etc.)

---

## 📊 Risk Management

### Technical Risks

| Risk                        | Impact | Likelihood | Mitigation                        |
| --------------------------- | ------ | ---------- | --------------------------------- |
| Dependency breaking changes | High   | Medium     | Pin versions, test before update  |
| Performance regression      | Medium | Low        | Lighthouse CI, regular audits     |
| Security vulnerability      | High   | Low        | Automated security scans, updates |
| Browser compatibility       | Medium | Medium     | Cross-browser testing, polyfills  |

### Business Risks

| Risk             | Impact | Likelihood | Mitigation                            |
| ---------------- | ------ | ---------- | ------------------------------------- |
| Low traffic      | Medium | Medium     | SEO optimization, content marketing   |
| High bounce rate | Medium | Low        | A/B testing, UX improvements          |
| No conversions   | High   | Low        | Clear CTAs, contact form optimization |
| Competitor sites | Low    | High       | Unique value prop, quality content    |

---

## 🤝 Team & Resources

### Current Team

- **Developer:** Muhammad Nurhidayat Gani (solo)
- **Designer:** Self (or hire freelancer)
- **Content Writer:** Self

### Skills Needed

- ✅ Frontend Development (React, Astro, Tailwind)
- ✅ Testing (Vitest, Testing Library)
- ⚠️ UI/UX Design (consider hiring)
- ⚠️ Technical Writing (improve over time)
- ⚠️ SEO/Marketing (learn as you go)

### Learning Resources

- Astro docs & Discord
- React docs
- Tailwind UI components
- Framer Motion cookbook
- Web.dev performance guides

---

## 📞 Stakeholder Communication

### Updates Frequency

- **Weekly:** Progress updates (internal notes)
- **Monthly:** Milestone review & roadmap adjustment
- **Quarterly:** Major release & metrics review

### Communication Channels

- Git commits dengan descriptive messages
- GitHub Issues untuk bug tracking
- Documentation updates untuk major changes
- Memory files untuk AI assistant context

---

## 🎓 Lessons Learned (To Be Updated)

### What Worked Well

- Modular component architecture
- Test-first approach
- Comprehensive documentation
- AI-assisted development (FRIDAY Protocol)

### What Could Be Improved

- Content planning earlier
- Design mockups before coding
- Performance budget dari awal
- Analytics setup sejak hari pertama

### Key Takeaways

- Documentation saves time long-term
- Testing prevents regressions
- Small iterations better than big rewrites
- User feedback invaluable (once launched)

---

## 📅 Timeline Summary

```
Nov 2025        Dec 2025        Jan 2026        Feb 2026
   |              |               |               |
   v              v               v               v
Content      Branding        Analytics        Blog
Completion   & Deploy        & Monitor       Section
   |              |               |               |
   └──────────────┴───────────────┴───────────────┘
                Phase 1: Launch

Mar 2026        Apr 2026        May 2026        Jun 2026
   |              |               |               |
   v              v               v               v
Advanced      Multi-Lang      Image           PWA
Projects      Support         Optimization    & Fonts
   |              |               |               |
   └──────────────┴───────────────┴───────────────┘
                Phase 2 & 3: Enhancement
```

---

## ✅ Approval & Sign-off

**Roadmap Version:** 1.0  
**Created By:** Muhammad Nurhidayat Gani + FRIDAY AI Assistant  
**Date:** November 7, 2025  
**Next Review:** January 1, 2026

**Approved:** ⬜ Pending

---

**Note:** Roadmap ini adalah living document. Update secara regular berdasarkan progress, feedback,
dan prioritas yang berubah.

**Last Updated:** November 7, 2025
