#!/usr/bin/awk -f

BEGIN{
    FS="_#_"
    OFS="_#_"
    w=0.3142618808677668
    a=0.30694707713066155
    b=0.2778932422698838
    c=0.026737650134167606
    d=0.0765247592818062
    }

{
    #printf "%f,%f,%f,%f\n" ,w,a,b,c
    #if( length($1) > 4 ){
    #    print $1
    #}
    #else{
    #    print "none"
    #}

    if( ( length($1)>4 || length($1)<2 ) && length($2)!=0 && length($3)!=0 && length($4)!=0 && length($5)!=0 && length($6)!=0 ){
        $1 = w*$2 + a*$3 + b*$4 + c*$5 + d*$6
        print
        }
    else if ( length($1)==0 && ( length($2)==0 || length($3)==0 || length($4)==0 || length($5)==0 || length($6)==0 ) ){
        printf " \n"
        }
    else
        print
}

