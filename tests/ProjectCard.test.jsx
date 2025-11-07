import { describe, test, expect } from 'vitest';
import { render, screen } from '@testing-library/react';
import ProjectCard from '../src/components/ProjectCard.jsx';

describe('ProjectCard', () => {
  const mockProject = {
    slug: 'test-project',
    title: 'Test Project',
    summary: 'A test project description',
    tags: ['React', 'Testing'],
    cover: 'https://example.com/image.jpg',
    alt: 'Test image',
  };

  test('renders project title', () => {
    render(<ProjectCard project={mockProject} />);
    expect(screen.getByText('Test Project')).toBeInTheDocument();
  });

  test('renders project summary', () => {
    render(<ProjectCard project={mockProject} />);
    expect(screen.getByText('A test project description')).toBeInTheDocument();
  });

  test('renders project tags', () => {
    render(<ProjectCard project={mockProject} />);
    expect(screen.getByText('React')).toBeInTheDocument();
    expect(screen.getByText('Testing')).toBeInTheDocument();
  });

  test('links to project detail page', () => {
    render(<ProjectCard project={mockProject} />);
    const link = screen.getByRole('link');
    expect(link).toHaveAttribute('href', '/projects/test-project');
  });

  test('renders cover image with alt text', () => {
    render(<ProjectCard project={mockProject} />);
    const image = screen.getByAltText('Test image');
    expect(image).toBeInTheDocument();
    expect(image).toHaveAttribute('src', 'https://example.com/image.jpg');
  });

  test('uses title as alt text fallback when alt prop missing', () => {
    const projectWithoutAlt = { ...mockProject, alt: undefined };
    render(<ProjectCard project={projectWithoutAlt} />);
    const image = screen.getByAltText('Test Project');
    expect(image).toBeInTheDocument();
  });

  test('does not render image when cover is missing', () => {
    const projectWithoutCover = { ...mockProject, cover: undefined };
    render(<ProjectCard project={projectWithoutCover} />);
    const images = screen.queryAllByRole('img');
    expect(images).toHaveLength(0);
  });
});
