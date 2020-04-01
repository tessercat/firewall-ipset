# Commands to restore, flush and reload ipsets.
BIN=/sbin/ipset
BASE=/opt/firewall/ipset
SETS=($($BIN list -name)) # IP sets in memory.

contains() {
    local elem match="$1"
    shift
    for elem; do
        [[ "$elem" == "$match" ]] && return 0
    done
    return 1
}

for ipset in blacklist4 blacklist6 whitelist4 whitelist6; do

    # Restore the set if it's not in memory.
    contains $ipset ${SETS[@]}
    if [ $? -ne 0 ]; then
        $BIN restore -file $BASE/sets/$ipset
        echo "Restored ipset $ipset"
    fi

    # Flush and reload the set.
    $BIN flush $ipset
    file=$BASE/lists/$ipset
    if [ -f $file ]; then
        while read -r line; do
            $BIN add $ipset $line
        done < $file
    fi
    echo "Flushed and reloaded ipset $ipset"
done
