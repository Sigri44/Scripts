machine="www.google.fr"
coupures=0
while true;
do
  PING=`ping -c 1 $machine`
  if [[ $? -eq 0 ]] ; then
    CMD_DATE=`date`
    DATE=`echo $CMD_DATE | tail -1 | cut -c 17-24`
    TIME=`echo $PING | tail -1 | cut -d/ -f 5`
    if [[ ${TIME} < 20 ]] ; then
        echo ${DATE} : ping sur $machine : `echo -e "\033[30m\033[42m${TIME} ms\033[0m"`
    elif ([ ${TIME} > 20 ] && [ ${TIME} < 99 ]) ; then
        echo ${TIME}
        echo ${DATE} : ping sur $machine : `echo -e "\033[30m\033[43m${TIME} ms\033[0m"`
    elif [[ ${TIME} > 99 ]] ; then
        echo ${TIME}
        echo ${DATE} : ping sur $machine : `echo -e "\033[30m\033[41m${TIME} ms\033[0m"`
    else
        echo Erreur non référencée
    fi
    sleep 1
  else
    #$coupures = $coupures + 1
    $coupures = $coupures + 1
    #var=$((var + 1))

    CMD_DATE=`date`
    DATE=`echo $CMD_DATE | tail -1 | cut -c 17-24`
    echo ${DATE} : Coupure réseau - Impossible de joindre la machine $machine
    echo ${DATE} : Nb de coupures réseau : $coupures
  fi
done
done
