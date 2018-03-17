#!/usr/bin/awk -f





# The script is incomplete

BEGIN{
    FS="_#_"
    OFS="_#_"
}

{
    if(NR==FNR){
        uni[$2] = 1
    }

    if(NR!=FNR){
        if(uni[$2] == 1 || FNR <= 50){
            a="[O]"
        }else{
            a="[X]"
        }
        printf "%s %s\n" ,a,$2
    }
}
