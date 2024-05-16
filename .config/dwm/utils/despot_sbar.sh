#!/usr/bin/bash
 
dwm_kbd_layout(){
    t=$(xset -q | grep LED)
    code=${t##*mask:  }
    if [[ $code -eq "00000002" ]]; then
            result="󰌌 EN"
    else
            result="󰌌 RU"
    fi
    echo $result
}

dwm_fdatetime(){
    local dt=$(date +"%F %T")
    printf "%s \\n" "$dt"
}

dwm_cmus(){
    artist=$(echo -n $(cmus-remote -C 'format_print %F'))

    if [[ $artist = *[!\ ]* ]]; then
#            song=$(echo -n $(cmus-remote -C status | grep title | cut -c 11-))
            position=$(cmus-remote -C status | grep position | cut -c 10-)
            minutes1=$(prepend_zero $(($position / 60)))
            seconds1=$(prepend_zero $(($position % 60)))
            duration=$(cmus-remote -C status | grep duration | cut -c 10-)
            minutes2=$(prepend_zero $(($duration / 60)))
            seconds2=$(prepend_zero $(($duration % 60)))
            echo -n "󰎆 $artist"
    else
            echo
    fi

}


dwm_mem(){
    mem="$(free -m | awk 'NR==2{printf "%s", $3,$2,$3*100/$2 }')"
    icon=" "
    #printf " ^c#e4b371^ %s %s \\n" "$icon""$mem"
    printf "%s %s \\n" "$icon""$mem"
}


dwm_cpu(){
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.2
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal) - (idle-previdle) ) / (total-prevtotal) ))
    icon="  "
#    printf " ^c#7ca198^ %s %s \\n" "$icon""$cpu%"
    printf "%s %s \\n" "$icon""$cpu%"
}

dwm_vol(){
    vol="$(amixer -c 1 -M -D pulse get Master | grep -m 1 -o -E [[:digit:]]+% | tr -d "%")"
    icon="  "
#    printf " ^c#e4b371^ %s %s \\n" "$icon""$vol%"  
    printf "%s %s \\n" "$icon""$vol%"  
}


dwm_status(){
    echo "$(dwm_cpu) $(dwm_mem) $(dwm_cmus) $(dwm_vol) $(dwm_kbd_layout) $(dwm_fdatetime)"
#    echo "$(cpu) $(mem) $(cmus) $(vol) $(kbd_layout)"
#    echo "$(cpu) $(mem) $(vol) $(kbd_layout) $(fdatetime)"
}

#dwm_status
