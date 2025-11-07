import { useMemo, useState } from 'react';
import { motion, AnimatePresence } from 'framer-motion';
import ProjectCard from './ProjectCard.jsx';

export default function ProjectFilter({ projects }) {
  const allTags = useMemo(() => {
    const s = new Set();
    projects.forEach(p => (p.tags || []).forEach(t => s.add(t)));
    return ['All', ...Array.from(s)];
  }, [projects]);
  const [active, setActive] = useState('All');
  const filtered = useMemo(() =>
    active === 'All' ? projects : projects.filter(p => p.tags?.includes(active)),
    [active, projects]
  );
  return (
    <div>
      <div className="flex flex-wrap gap-2 mb-6">
        {allTags.map(tag => (
          <button
            key={tag}
            className={`text-xs px-3 py-1 rounded-full border transition ${active===tag? 'bg-accent text-white border-accent' : 'hover:border-accent border-black/10 dark:border-white/20'}`}
            onClick={() => setActive(tag)}
          >{tag}</button>
        ))}
      </div>
      <motion.div layout className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
        <AnimatePresence>
          {filtered.map(p => (
            <motion.div key={p.slug} layout initial={{opacity:0, scale:0.98}} animate={{opacity:1, scale:1}} exit={{opacity:0}}>
              <ProjectCard project={p} />
            </motion.div>
          ))}
        </AnimatePresence>
      </motion.div>
    </div>
  );
}
