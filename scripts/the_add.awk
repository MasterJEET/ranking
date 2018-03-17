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
        if( length($3) > 4 || length($3) < 2 ){
            $3 = a[FNR]
        }
        print
    }
}
