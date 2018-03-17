#!/usr/bin/awk -f

BEGIN{
    FS="_#_"
    OFS="_#_"
    w=0.40876294373052385
    a=0.2971851150471359
    b=0.1580693872900155
    c=0.1368074137738007
    }

{
    #printf "%f,%f,%f,%f\n" ,w,a,b,c
    if( length($1)==0 && length($2)!=0 && length($3)!=0 && length($4)!=0 && length($5)!=0 ){
        $1 = w*$2 + a*$3 + b*$4 + c*$5
        print
        }
    else if ( length($1)==0 && ( length($2)==0 || length($3)==0 || length($4)==0 || length($5)==0 ) ){
        printf " \n"
        }
    else
        print
}
