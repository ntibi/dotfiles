#!/bin/bash
input=$(cat)

eval "$(echo "$input" | jq -r '[
  "MODEL="   + (.model.display_name // "?" | @sh),
  "CWD="     + (.cwd // "" | @sh),
  "COST="    + (.cost.total_cost_usd // 0 | tostring | @sh),
  "DUR_MS="  + (.cost.total_duration_ms // 0 | tostring | @sh),
  "API_MS="  + (.cost.total_api_duration_ms // 0 | tostring | @sh),
  "TOT_IN="  + (.context_window.total_input_tokens // 0 | tostring | @sh),
  "TOT_OUT=" + (.context_window.total_output_tokens // 0 | tostring | @sh),
  "WIN="     + (.context_window.context_window_size // 0 | tostring | @sh),
  "USED="    + (.context_window.used_percentage // 0 | tostring | @sh)
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
  if (( h > 0 )); then printf "%dh%02dm" "$h" "$m"
  elif (( m > 0 )); then printf "%dm%02ds" "$m" "$s"
  else printf "%ds" "$s"
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

used_int=${USED%.*}; used_int=${used_int:-0}
total_tok=$(( ${TOT_IN%.*} + ${TOT_OUT%.*} ))
cost_str=$(printf "%.2f" "$COST")
cwd_short="${CWD/"$HOME"/\~}"

if (( used_int < 50 )); then BC=$GREEN
elif (( used_int < 80 )); then BC=$YELLOW
else BC=$RED
fi

echo "${PURPLE}${B}${MODEL}${R}${S}${GREY}${cwd_short}${R}"
echo "${GREEN}\$${cost_str}${R}${S}${GREY}session ${R}${B}$(fmt_dur "$DUR_MS")${R}${S}${GREY}api ${R}${B}$(fmt_dur "$API_MS")${R}"
echo "${BC}${B}${used_int}%${S}$(fmt_tok $total_tok)${D}/${R}$(fmt_tok ${WIN%.*})${R}"
