#!/usr/bin/awk -f

BEGIN{
    FS="_#_"
    OFS="_#_"
}

{
    if(NR == FNR){
        a[FNR] = $1
    }
    else{
        if(length($3) == 0){
            $3 = a[FNR]
        }
        print
    }
}
