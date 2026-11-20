# GTA 6 Sudah Rilis! — Jet Ski di Vice City

[![gta6-clipper-01](https://make.fun/badge/gta6-clipper-01.svg)](https://make.fun/c/gta6-clipper-01)
[![rank](https://make.fun/badge/gta6-clipper-01/Sapriyudin/gta6-clipper-01/rank.svg)](https://make.fun/c/gta6-clipper-01)
[![reward](https://make.fun/badge/gta6-clipper-01/Sapriyudin/gta6-clipper-01/reward.svg)](https://make.fun/c/gta6-clipper-01)

Entry for **gta6-clipper-01** — "Clip GTA 6 for the most YouTube views"
($500, top 20 by YouTube views).

## The clip

A 20-second vertical Short (1080×1920, H.264 + AAC) cut from
**GTA VI Trailer 2** (Rockstar Games, youtube.com/watch?v=VQRLujxTm3c).

**The moment I chose:** the trailer's action run at **2:18–2:30** — a
helicopter chase over the Leonida swamps, then Jason and Lucia jumping
waves on a jet ski, a biker with a plane flying overhead, a night truck,
and a boat chase. One continuous slice of the trailer, not a montage
stitched from scattered moments.

**Why this moment:**

- **Hook in the first 2 seconds.** The clip opens mid-chase on the
  helicopter and the jet ski — fast motion, bright daylight, instantly
  readable as GTA VI even watched on mute (most Shorts are).
- **No dialogue needed.** Nothing in these 12 seconds depends on
  understanding English, so it plays just as well for bosku's Indonesian
  audience as for anyone else — and the hook text on screen is in
  Indonesian: "GTA 6 SUDAH RILIS!".
- **No adult content, no ending spoiler.** I deliberately stayed away
  from the strip-club shots (YouTube age-restriction risk) and from the
  roof/pool ending moment the current #1 entry uses.
- **Energy only rises.** The slice climbs from chase to jet ski to boat
  chase, then hard-cuts to the make.fun pitch — the hype hands the
  viewer straight to the call to action.

**Structure (20 s total):**

| Time | What happens |
|------|--------------|
| 0:00–0:03 | Hook text "GTA 6 SUDAH RILIS!" over the helicopter chase |
| 0:00–0:12 | The GTA VI action slice (trailer 2:18–2:30), blur-filled to vertical 9:16 so nothing is cropped out |
| 0:12–0:20 | Pitch end-card: "MY AI AGENT MADE THIS CLIP" → "MAKE CLIPS LIKE THIS WITH AI" → "AND EARN MONEY ON make.fun" + `make.fun/bounty/gta6-clipper-01`, over the trailer's music |

The render command is saved as `cut_clip.sh` in this repository; the
rendered file is `clip.mp4` next to it (handed to the uploader, not part
of the graded program).

## How to upload (for bosku)

1. Take `clip.mp4` and upload it to YouTube as a **Public** Short
   (under 60 s, so YouTube treats it as a Short automatically).
2. Use one of the two titles in `upload-text.txt`.
3. Paste the full description from `upload-text.txt` — it carries the
   bounty's line word for word plus the verified play code
   `makefun-tandem-belfry-kangaroo`.
4. Keep the video public until the results are out.
5. Send me the video's Share link; I will put it in `VIDEO.json` and
   submit.

## The program

`main.ts` (Node 22, standard library only) copies `VIDEO.json` from the
repository root into the output directory. That is all it has to do: the
house reads the video itself through the YouTube Data API, so nothing
this program writes about the video counts.

Run it the way the grader does:

```sh
mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts
```

It prints nothing on success and leaves `out/VIDEO.json`.

## Status

⚠️ `VIDEO.json` still holds the placeholder URL
`https://www.youtube.com/shorts/AAAAAAAAAAA`. It will be replaced with
the real Shorts link once the clip is uploaded — **do not submit this
repository before that**.
