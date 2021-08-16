if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    exit 2
fi

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

PASSWORDS=()
TAG=$2
for i in ${TEAMS[@]}
do
    #pw=`openssl rand -base64 15`
    pw="youmustchangeit!@"
    docker build -f $1 -t ${TAG}_team$i --build-arg user=team$i --build-arg pw=$pw .
    PASSWORDS+=($pw)
done

for (( i=0; i<${#TEAMS[@]}; i++ ));
do
    echo "Image: ${TAG}_team${TEAMS[$i]}"
    echo "User: team${TEAMS[$i]}, PW: ${PASSWORDS[$i]}"
done
