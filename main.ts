// gta6-clipper-01 entry program.
//
// What it does, in one sentence: it copies VIDEO.json from the repository
// into the grader's output directory, and nothing else.
//
// Why it is this small on purpose: the house reads the video itself through
// the YouTube Data API (views, public status, description line, play code),
// so nothing this program writes about the video could ever count. The
// sealed scorer only needs VIDEO.json to land in /output next to the house's
// own video.counts.json. Keeping the program a plain copy also keeps both
// grading runs byte-identical: no network, no clock, no files outside the
// repository, no randomness.
//
// How the grader runs it (from the kit's AGENT.md):
//   mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts
//
// The two environment variables are the only inputs:
//   MAKEFUN_BOT_DIR    - where the repository lives (default: /bot)
//   MAKEFUN_OUTPUT_DIR - where VIDEO.json must be written (default: /output)
//
// Written fresh in the recorded build session for this entry (2026-11-20),
// after the competition opened (2026-11-20T01:00:00Z).

import * as fs from "node:fs";
import * as path from "node:path";

// The repository root and the output directory come from the environment,
// with the grader's defaults when they are unset.
const botDir: string = process.env.MAKEFUN_BOT_DIR ?? "/bot";
const outputDir: string = process.env.MAKEFUN_OUTPUT_DIR ?? "/output";

// VIDEO.json lives at the repository root and is the entry's only payload.
const sourcePath: string = path.join(botDir, "VIDEO.json");
const targetPath: string = path.join(outputDir, "VIDEO.json");

try {
  // The output directory may not exist yet on a fresh grading run.
  fs.mkdirSync(outputDir, { recursive: true });

  // A straight byte-for-byte copy: the file the scorer reads must be the
  // file the repository holds, so no parsing or rewriting happens here.
  fs.copyFileSync(sourcePath, targetPath);

  // Read back what was written and confirm it is still a JSON object with
  // a string url. This catches a truncated or corrupted copy (a bad disk,
  // a bad path) instead of letting the scorer fail on it later with a
  // less helpful error. It changes no bytes: the check only reads.
  const written: string = fs.readFileSync(targetPath, "utf8");
  const parsed: unknown = JSON.parse(written);
  if (
    typeof parsed !== "object" ||
    parsed === null ||
    typeof (parsed as { url?: unknown }).url !== "string"
  ) {
    throw new Error(
      `${targetPath} is not a JSON object with a string "url" property`,
    );
  }
} catch (error) {
  // A failed copy means the entry cannot be graded at all, so fail loudly
  // with the paths involved instead of exiting quietly with no output.
  const reason: string = error instanceof Error ? error.message : String(error);
  console.error(
    `gta6-clipper-01: could not copy VIDEO.json from ${sourcePath} to ${targetPath}: ${reason}`,
  );
  process.exit(1);
}
