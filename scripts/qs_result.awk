#!/usr/bin/awk -f

BEGIN{
    FS="_#_"
    OFS=","
    i=1
}

FNR!=1{
    if(check[$2] != 1){
        check[$2] = 1;
        uni[i]=$2
        i = i + 1
    }

    a[$2] = a[$2] + $3
}

END{
    for(j=1;j<i;j=j+1){
        printf "%f _#_ %s\n" ,a[uni[j]],uni[j]
    }
}
