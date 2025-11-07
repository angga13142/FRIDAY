import { motion } from 'framer-motion';

export default function ProjectCard({ project }) {
  return (
    <motion.a
      href={`/projects/${project.slug}`}
      className="group rounded-xl overflow-hidden border border-black/5 dark:border-white/10 bg-white dark:bg-[#151515] hover:shadow-card transition block"
      initial={{ opacity: 0, y: 20 }}
      whileInView={{ opacity: 1, y: 0 }}
      viewport={{ once: true }}
    >
      {project.cover && (
        <div className="aspect-video bg-black/5 dark:bg-white/5 overflow-hidden">
          <img
            src={project.cover}
            alt={project.alt || project.title}
            className="w-full h-full object-cover group-hover:scale-[1.02] transition"
            loading="lazy"
            width="1200"
            height="675"
          />
        </div>
      )}
      <div className="p-4">
        <h3 className="font-semibold text-lg mb-1">{project.title}</h3>
        <p className="text-sm text-black/70 dark:text-white/70 line-clamp-3">{project.summary}</p>
        {project.tags && (
          <div className="mt-3 flex flex-wrap gap-2">
            {project.tags.map((t) => (
              <span key={t} className="text-xs px-2 py-1 rounded bg-black/5 dark:bg-white/10">{t}</span>
            ))}
          </div>
        )}
      </div>
    </motion.a>
  );
}
