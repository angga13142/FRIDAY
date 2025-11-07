import { describe, test, expect } from 'vitest';
import projects from '../src/data/projects.json';

describe('Projects Data', () => {
  test('projects data is valid array', () => {
    expect(Array.isArray(projects)).toBe(true);
    expect(projects.length).toBeGreaterThan(0);
  });

  test('each project has required fields', () => {
    projects.forEach((project) => {
      expect(project).toHaveProperty('slug');
      expect(project).toHaveProperty('title');
      expect(project).toHaveProperty('summary');
      expect(project).toHaveProperty('tags');
      expect(project).toHaveProperty('cover');
    });
  });

  test('project slugs are unique', () => {
    const slugs = projects.map((p) => p.slug);
    const uniqueSlugs = new Set(slugs);
    expect(slugs.length).toBe(uniqueSlugs.size);
  });

  test('project slugs are URL-safe', () => {
    projects.forEach((project) => {
      expect(project.slug).toMatch(/^[a-z0-9-]+$/);
    });
  });

  test('project tags are arrays', () => {
    projects.forEach((project) => {
      expect(Array.isArray(project.tags)).toBe(true);
    });
  });

  test('project titles are not empty', () => {
    projects.forEach((project) => {
      expect(project.title.trim().length).toBeGreaterThan(0);
    });
  });

  test('project summaries are reasonable length', () => {
    projects.forEach((project) => {
      expect(project.summary.length).toBeGreaterThan(10);
      expect(project.summary.length).toBeLessThan(300);
    });
  });

  test('project cover images are valid URLs', () => {
    projects.forEach((project) => {
      expect(project.cover).toMatch(/^https?:\/\//);
    });
  });

  test('project links are valid URLs when present', () => {
    projects.forEach((project) => {
      if (project.links?.demo) {
        expect(project.links.demo).toMatch(/^https?:\/\//);
      }
      if (project.links?.source) {
        expect(project.links.source).toMatch(/^https?:\/\//);
      }
    });
  });
});
