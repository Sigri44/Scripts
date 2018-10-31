
#!/bin/bash
machine="www.google.fr"
coupures=0
min=40
max=149
while true;
do
  CMD_DATE=$(date)
  DATE=$(echo "$CMD_DATE" | tail -1 | cut -c 17-24)
  PING=$(ping -c 1 $machine)
  if [ "$PING" ] ; then
    TIME=$(echo "$PING" | tail -1 | cut -d/ -f 5 | cut -d. -f 1)
    if [ "${TIME}" -lt $min ] ; then
        echo "${DATE}" : ping sur $machine : "$(echo -e "\033[30m\033[42m${TIME} ms\033[0m")"
    elif [ "${TIME}" -gt $min ] && [ "${TIME}" -lt $max ]  ; then
        echo "${DATE}" : ping sur $machine : "$(echo -e "\033[30m\033[43m${TIME} ms\033[0m")"
    else
        echo "${DATE}" : ping sur $machine : "$(echo -e "\033[30m\033[41m${TIME} ms\033[0m")"
    fi
    sleep 1
  else
    $coupures++
    echo "${DATE} : Coupure réseau détectée - (Nb de coupures réseau : $coupures)"
  fi
done
