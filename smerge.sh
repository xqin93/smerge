#!/bin/bash

if [[ $# != 0 && $1 != '-' && $# < 3 ]]; then
#    echo bad args: [$*]
#    echo
    echo Usage:
    echo '...    <username|->    [uid]    [gid]        [cmd...]'
    echo '       - for root      request if not root'
    exit 10
fi

pName='root'
pUid=0
pGid=0
if [[ $# != 0 && $1 != '-' ]]; then
    pName=$1
    pUid=$2
    pGid=$3
fi

if [[ $pUid != 0 ]]; then
    #echo "create pseudo user: $pName uid($pUid) gid($pGid)"
    groupadd -r --gid $pUid $pName                                                  \
    || (echo create group err. ; exit 20;)
    useradd -r -l -d /home/$pName --create-home -u $pUid -g $pGid $pName            \
    || (echo create user err. ; exit 30;)
    #echo created. `id $pName`
    ln -s /root/.Xauthority /home/$pName

    echo -n 'run as ' ; gosu $pName id
    gosu $pName smerge
else
    echo run as `id`
    smerge
fi


