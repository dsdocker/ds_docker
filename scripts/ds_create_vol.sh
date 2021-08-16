# Team mapping
HOSTNAME=`hostname`
case $HOSTNAME in
    "ds1") TEAMS=(1 2) ;;
    "ds2") TEAMS=(3 4) ;;
    "ds3") TEAMS=(5 6) ;;
    "ds4") TEAMS=(7 8) ;;
    "ds5") TEAMS=(9 10) ;;
    "ds6") TEAMS=(11 12) ;;
esac

for (( i=0; i<${#TEAMS[@]}; i++ ));
do
    #echo $d

    p=/data/disk${i}/ds_docker_volumes/team${TEAMS[$i]}-home
    sudo mkdir -p $p
    docker volume create --driver local --opt type=none --opt device=$p --opt o=bind team${TEAMS[$i]}-home
done
