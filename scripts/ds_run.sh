if [ "$#" -ne 1 ]; then
    echo "Illegal number of parameters"
    exit 2
fi

CPU='12'
MEM='128GB'
MEMANDSWAP='144GB'
GPUS=("0,1,2" "3,4,5")

# Team mapping
HOSTNAME=`hostname`
case $HOSTNAME in
    "ds1") TEAMS=(1 2)   ;;
    "ds2") TEAMS=(3 4)   ;;
    "ds3") TEAMS=(5 6)   ;;
    "ds4") TEAMS=(7 8)   ;;
    "ds5") TEAMS=(9 10)  ;;
    "ds6") TEAMS=(11 12) ;;
esac

TAG=$1
SSH_PORT_BASE=8900
JUP_PORT_BASE=9000
EXT_PORT_BASE=10000
for (( i=0; i<${#TEAMS[@]}; i++ ));
do
    team=${TEAMS[$i]}
    gpu=${GPUS[$i]}
    ssh_port=$((SSH_PORT_BASE + $i))
    jupyterhub_port=$((JUP_PORT_BASE + $i))
    ext_port=$((EXT_PORT_BASE + $i))
    team_tag=${TAG}_team$team
    echo "Team: $team, Image: $team_tag, GPU: $gpu, SSH Port: $ssh_port, JupyterHub Port: $jupyterhub_port"
    echo "device=$gpu"
    gpu_arg=\""device=$gpu"\"
    echo "docker run --restart always --cpus=$CPU --gpus $gpu_arg --memory $MEM --memory-swap $MEMANDSWAP --shm-size=32G --name ${TAG}_team${team}  -p $ssh_port:22 -p $jupyterhub_port:8000 -p $ext_port:10000 -v team${team}-home:/home -d $team_tag"
    docker run --restart always --cpus=$CPU --gpus $gpu_arg --memory $MEM --memory-swap $MEMANDSWAP --shm-size=32G --name ${TAG}_team${team}  -p $ssh_port:22 -p $jupyterhub_port:8000 -p $ext_port:10000 -v team${team}-home:/home -d $team_tag

    echo "done"
done
