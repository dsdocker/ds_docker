NUM_TA=15
PASSWORDS=()
for (( i=0; i<$NUM_TA; i++ ));
do
    user=ta$i
    pw=`openssl rand -base64 15`
    useradd --create-home --shell /bin/bash $user
    adduser $user docker
    echo "$user:$pw" | chpasswd
    PASSWORDS+=($pw)
done

for (( i=0; i<$NUM_TA; i++ ));
do
    echo ta$i	${PASSWORDS[$i]}
done
