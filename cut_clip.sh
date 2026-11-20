#!/bin/bash
# gta6-clipper-01 — cut GTA VI Trailer 2 (2:18-2:30) into a 20 s vertical Short.
#
# Layout (1080x1920, 30 fps, H.264 + AAC):
#   0:00-0:12  action moment, 16:9 footage blur-filled to 9:16,
#              hook text "GTA 6 SUDAH RILIS!" on a dark band, 0-3 s.
#   0:12-0:20  end card: solid dark background #141414 + magenta line,
#              three pitch lines shown STRICTLY ONE AT A TIME (hard cuts,
#              no overlapping fades — a previous version overlapped lines 1
#              and 2 at t=14 and became unreadable):
#                line 1  12.0-14.6  "MY AI AGENT MADE THIS CLIP"
#                line 2  14.6-17.0  "MAKE CLIPS LIKE THIS WITH AI"
#                line 3  17.0-20.0  "AND EARN MONEY ON" / "make.fun" / URL
#              trailer music runs underneath with a fade-out at 18-20 s.
#
# Usage: ./cut_clip.sh   (writes ../clip.mp4, deterministic)
set -euo pipefail

SRC="$HOME/workspace/makefun/gta6-clipper/src/gta6-trailer2.mp4"
OUT="$HOME/workspace/makefun/gta6-clipper/clip.mp4"
FONT="/usr/share/fonts/truetype/dejavu/DejaVuSans-Bold.ttf"

ffmpeg -y -v error \
  -i "$SRC" \
  -filter_complex "\
[0:v]trim=138:150,setpts=PTS-STARTPTS,split=2[bg_in][fg_in]; \
[bg_in]scale=1080:1920:force_original_aspect_ratio=increase,crop=1080:1920,gblur=sigma=40[bg]; \
[fg_in]scale=1080:608[fg]; \
[bg][fg]overlay=(W-w)/2:(H-h)/2,setsar=1[action]; \
color=c=0x141414:s=1080x1920:r=30:d=8,drawbox=x=0:y=576:w=1080:h=10:color=0xC21C82:t=fill,setsar=1[end]; \
[action][end]concat=n=2:v=1:a=0,format=yuv420p, \
drawbox=x=20:y=182:w=1040:h=104:color=black@0.55:t=fill:enable='lt(t\,3)', \
drawtext=fontfile=$FONT:text='GTA 6 SUDAH RILIS!':fontsize=88:fontcolor=white:x=(w-text_w)/2:y=192:enable='lt(t\,3)', \
drawtext=fontfile=$FONT:text='MY AI AGENT MADE THIS CLIP':fontsize=58:fontcolor=white:x=(w-text_w)/2:y=692:enable='gte(t\,12)*lt(t\,14.6)', \
drawtext=fontfile=$FONT:text='MAKE CLIPS LIKE THIS WITH AI':fontsize=58:fontcolor=white:x=(w-text_w)/2:y=692:enable='gte(t\,14.6)*lt(t\,17)', \
drawtext=fontfile=$FONT:text='AND EARN MONEY ON':fontsize=64:fontcolor=white:x=(w-text_w)/2:y=692:enable='gte(t\,17)', \
drawtext=fontfile=$FONT:text='make.fun':fontsize=110:fontcolor=0xF9E011:x=(w-text_w)/2:y=845:enable='gte(t\,17)', \
drawtext=fontfile=$FONT:text='make.fun/bounty/gta6-clipper-01':fontsize=44:fontcolor=white:x=(w-text_w)/2:y=1075:enable='gte(t\,17)'[vout]; \
[0:a]atrim=138:158,asetpts=PTS-STARTPTS,afade=t=out:st=18:d=2[aout]" \
  -map "[vout]" -map "[aout]" \
  -c:v libx264 -preset medium -crf 20 -r 30 \
  -c:a aac -b:a 128k -ar 44100 -ac 2 \
  -metadata creation_time= \
  -t 20 "$OUT"

echo "wrote $OUT"
