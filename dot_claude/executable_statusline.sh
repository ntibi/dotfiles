#!/bin/bash
input=$(cat)

USAGE_CACHE="/tmp/claude-usage-cache.json"
USAGE_TTL=60

fetch_usage() {
  local token creds
  creds="$HOME/.claude/.credentials.json"
  [[ -f "$creds" ]] || return
  token=$(jq -r '.claudeAiOauth.accessToken // empty' "$creds" 2>/dev/null)
  [[ -n "$token" ]] || return
  local resp
  resp=$(curl -s --max-time 3 "https://api.anthropic.com/api/oauth/usage" \
    -H "Authorization: Bearer $token" \
    -H "anthropic-beta: oauth-2025-04-20" \
    -H "Content-Type: application/json" 2>/dev/null)
  [[ -n "$resp" ]] || return
  local now=$(date +%s)
  echo "$resp" | jq --argjson ts "$now" '. + {cached_at: $ts}' > "$USAGE_CACHE" 2>/dev/null
}

read_usage() {
  U5H=""; U7D=""
  if [[ -f "$USAGE_CACHE" ]]; then
    local cached_ts=$(jq -r '.cached_at // 0' "$USAGE_CACHE" 2>/dev/null)
    local now=$(date +%s)
    if (( now - cached_ts > USAGE_TTL )); then
      fetch_usage
    fi
  else
    fetch_usage
  fi
  [[ -f "$USAGE_CACHE" ]] || return
  U5H=$(jq -r '.five_hour.utilization // empty' "$USAGE_CACHE" 2>/dev/null)
  U5R=$(jq -r '.five_hour.resets_at // empty' "$USAGE_CACHE" 2>/dev/null)
  U7D=$(jq -r '.seven_day.utilization // empty' "$USAGE_CACHE" 2>/dev/null)
  U7R=$(jq -r '.seven_day.resets_at // empty' "$USAGE_CACHE" 2>/dev/null)
}

read_usage

eval "$(echo "$input" | jq -r '[
  "MODEL="   + (.model.display_name // "?" | @sh),
  "CWD="     + (.cwd // "" | @sh),
  "COST="    + (.cost.total_cost_usd // 0 | tostring | @sh),
  "DUR_MS="  + (.cost.total_duration_ms // 0 | tostring | @sh),
  "API_MS="  + (.cost.total_api_duration_ms // 0 | tostring | @sh),
  "TOT_IN="  + (.context_window.total_input_tokens // 0 | tostring | @sh),
  "TOT_OUT=" + (.context_window.total_output_tokens // 0 | tostring | @sh),
  "WIN="     + (.context_window.context_window_size // 0 | tostring | @sh),
  "USED="    + (.context_window.used_percentage // 0 | tostring | @sh),
  "CUR_IN="  + (.context_window.current_usage.input_tokens // 0 | tostring | @sh),
  "CUR_OUT=" + (.context_window.current_usage.output_tokens // 0 | tostring | @sh),
  "CUR_CC="  + (.context_window.current_usage.cache_creation_input_tokens // 0 | tostring | @sh),
  "CUR_CR="  + (.context_window.current_usage.cache_read_input_tokens // 0 | tostring | @sh)
] | join("\n")')" 2>/dev/null || exit 0

fmt_tok() {
  local n=${1%.*}; n=${n:-0}
  if (( n >= 1000000 )); then
    printf "%d.%dM" $((n / 1000000)) $(( (n % 1000000) / 100000 ))
  elif (( n >= 1000 )); then
    printf "%d.%dk" $((n / 1000)) $(( (n % 1000) / 100 ))
  else
    printf "%d" "$n"
  fi
}

fmt_dur() {
  local ms=${1%.*}; ms=${ms:-0}
  local s=$((ms / 1000)) m h
  h=$((s / 3600)); m=$(( (s % 3600) / 60 )); s=$((s % 60))
  if (( h > 0 )); then printf "%dh %02dm " "$h" "$m"
  elif (( m > 0 )); then printf "%dm %02ds" "$m" "$s"
  else printf "%ds" "$s"
  fi
}

fmt_reset() {
  local reset_at=$1
  [[ -n "$reset_at" ]] || return
  local reset_ts=$(date -d "$reset_at" +%s 2>/dev/null)
  [[ -n "$reset_ts" ]] || return
  local now=$(date +%s)
  local diff=$(( reset_ts - now ))
  (( diff < 0 )) && diff=0
  local d=$(( diff / 86400 )) h=$(( (diff % 86400) / 3600 )) m=$(( (diff % 3600) / 60 ))
  if (( d > 0 )); then printf "%dd%02dh" "$d" "$h"
  elif (( h > 0 )); then printf "%dh%02dm" "$h" "$m"
  else printf "%dm" "$m"
  fi
}

R=$(tput sgr0)
B=$(tput bold)
D=$(tput dim)
PURPLE=$(tput setaf 141)
GREEN=$(tput setaf 114)
YELLOW=$(tput setaf 180)
RED=$(tput setaf 174)
GREY=$(tput setaf 248)
DGREY=$(tput setaf 240)
S=" ${D}${DGREY}|${R} "

win_int=${WIN%.*}; win_int=${win_int:-0}
ctx_tok=$(( ${CUR_IN%.*} + ${CUR_OUT%.*} + ${CUR_CC%.*} + ${CUR_CR%.*} ))
cost_str=$(printf "%.2f" "$COST")
cwd_short="${CWD/"$HOME"/\~}"
in=${TOT_IN%.*}; in=${in:-0}
out=${TOT_OUT%.*}; out=${out:-0}

AUTOCOMPACT_BUFFER=${CLAUDE_AUTOCOMPACT_BUFFER:-33000}
compact_limit=$(( win_int - AUTOCOMPACT_BUFFER ))
if (( compact_limit > 0 )); then
  used_int=$(( ctx_tok * 100 / compact_limit ))
else
  used_int=${USED%.*}; used_int=${used_int:-0}
fi

if (( used_int < 75 )); then BC=$GREEN
elif (( used_int < 90 )); then BC=$YELLOW
else BC=$RED
fi

echo "${PURPLE}${B}${MODEL}${R}${S}${GREY}${cwd_short}${R}"
echo "${GREEN}\$${cost_str}${R}${S}${GREY}session ${R}${B}$(fmt_dur "$DUR_MS")${R}${S}${GREY}api ${R}${B}$(fmt_dur "$API_MS")${R}"
usage_str=""
if [[ -n "$U5H" ]]; then
  u5=${U5H%.*}; u5=${u5:-0}
  if (( u5 < 50 )); then UC5=$GREEN; elif (( u5 < 80 )); then UC5=$YELLOW; else UC5=$RED; fi
  r5=$(fmt_reset "$U5R")
  r5_str=""
  [[ -n "$r5" ]] && r5_str="${D}(${r5})${R}"
  usage_str="${GREY}5h${R}${r5_str}${GREY} ${R}${UC5}${B}${u5}%${R}"
fi
if [[ -n "$U7D" ]]; then
  u7=${U7D%.*}; u7=${u7:-0}
  if (( u7 < 50 )); then UC7=$GREEN; elif (( u7 < 80 )); then UC7=$YELLOW; else UC7=$RED; fi
  r7=$(fmt_reset "$U7R")
  r7_str=""
  [[ -n "$r7" ]] && r7_str="${D}(${r7})${R}"
  usage_str="${usage_str}${S}${GREY}7d${R}${r7_str}${GREY} ${R}${UC7}${B}${u7}%${R}"
fi

echo "${BC}${B}${used_int}%${R}${S}${B}$(fmt_tok $ctx_tok)${D}/${R}$(fmt_tok $compact_limit)${R}${S}${GREY}i:${R}${B}$(fmt_tok $in)${R} ${GREY}o:${R}${B}$(fmt_tok $out)${R}"
echo "${usage_str}"
