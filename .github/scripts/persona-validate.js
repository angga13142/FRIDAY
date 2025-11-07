#!/usr/bin/env node
/**
 * Persona validation script
 * Ensures required persona instruction files exist and are referenced.
 */
const fs = require('fs');
const path = require('path');

const ROOT = path.resolve(__dirname, '..');
const INSTRUCTIONS = path.join(ROOT, 'instructions');
const REQUIRED = [
  'persona-modes.md',
  'persona-guardrails.md',
  'persona-evals.md',
  'tooling-matrix.md',
  'persona-instrumentation.md',
  'persona-fewshots.md'
];

function main() {
  let ok = true;
  const missing = [];
  for (const f of REQUIRED) {
    if (!fs.existsSync(path.join(INSTRUCTIONS, f))) {
      ok = false;
      missing.push(f);
    }
  }
  const copilotPath = path.join(ROOT, 'copilot-instructions.md');
  const copilot = fs.readFileSync(copilotPath, 'utf-8');
  const notReferenced = REQUIRED.filter(f => !copilot.includes(f));

  if (!ok) {
    console.error('❌ Missing persona files:', missing.join(', '));
  } else {
    console.log('✅ All persona files present.');
  }
  if (notReferenced.length) {
    console.warn('⚠️ Not referenced in copilot-instructions.md:', notReferenced.join(', '));
  } else {
    console.log('✅ All persona files referenced in copilot-instructions.md');
  }

  process.exit(ok && notReferenced.length === 0 ? 0 : 1);
}

if (require.main === module) {
  main();
}
