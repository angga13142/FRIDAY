import { describe, test, expect } from 'vitest';
import { render, screen, fireEvent, waitFor } from '@testing-library/react';
import ProjectFilter from '../src/components/ProjectFilter.jsx';

describe('ProjectFilter', () => {
  const mockProjects = [
    {
      slug: 'project-1',
      title: 'Project 1',
      summary: 'Description 1',
      tags: ['React', 'Node.js'],
      cover: 'https://example.com/1.jpg',
    },
    {
      slug: 'project-2',
      title: 'Project 2',
      summary: 'Description 2',
      tags: ['Vue', 'Python'],
      cover: 'https://example.com/2.jpg',
    },
    {
      slug: 'project-3',
      title: 'Project 3',
      summary: 'Description 3',
      tags: ['React', 'Python'],
      cover: 'https://example.com/3.jpg',
    },
  ];

  test('renders all projects initially', () => {
    render(<ProjectFilter projects={mockProjects} />);
    expect(screen.getByText('Project 1')).toBeInTheDocument();
    expect(screen.getByText('Project 2')).toBeInTheDocument();
    expect(screen.getByText('Project 3')).toBeInTheDocument();
  });

  test('renders all filter tags', () => {
    render(<ProjectFilter projects={mockProjects} />);
    expect(screen.getByRole('button', { name: 'All' })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'React' })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Node.js' })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Vue' })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: 'Python' })).toBeInTheDocument();
  });

  test('All filter is active by default', () => {
    render(<ProjectFilter projects={mockProjects} />);
    const allButton = screen.getByRole('button', { name: 'All' });
    expect(allButton).toHaveClass('bg-accent');
  });

  test('filters projects by tag when clicked', async () => {
    render(<ProjectFilter projects={mockProjects} />);
    
    const reactButton = screen.getByRole('button', { name: 'React' });
    fireEvent.click(reactButton);

    await waitFor(() => {
      expect(screen.getByText('Project 1')).toBeInTheDocument();
      expect(screen.getByText('Project 3')).toBeInTheDocument();
      expect(screen.queryByText('Project 2')).not.toBeInTheDocument();
    });
  });

  test('shows all projects when All filter is clicked', () => {
    render(<ProjectFilter projects={mockProjects} />);
    
    // Click a specific filter first
    const reactButton = screen.getByRole('button', { name: 'React' });
    fireEvent.click(reactButton);

    // Then click All
    const allButton = screen.getByRole('button', { name: 'All' });
    fireEvent.click(allButton);

    expect(screen.getByText('Project 1')).toBeInTheDocument();
    expect(screen.getByText('Project 2')).toBeInTheDocument();
    expect(screen.getByText('Project 3')).toBeInTheDocument();
  });

  test('updates active filter styling', () => {
    render(<ProjectFilter projects={mockProjects} />);
    
    const pythonButton = screen.getByRole('button', { name: 'Python' });
    fireEvent.click(pythonButton);

    expect(pythonButton).toHaveClass('bg-accent');
    expect(screen.getByRole('button', { name: 'All' })).not.toHaveClass('bg-accent');
  });

  test('handles projects without tags', () => {
    const projectsWithoutTags = [
      { slug: 'p1', title: 'Project 1', summary: 'Desc', tags: [] },
    ];
    
    render(<ProjectFilter projects={projectsWithoutTags} />);
    expect(screen.getByRole('button', { name: 'All' })).toBeInTheDocument();
  });
});
