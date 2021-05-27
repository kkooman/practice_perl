use warnings;
use strict;
# -------------------------------------------------------------------
# print "perl -ne \"print if ( /search/ )\" inputfile.txt > outputfile.txt";
# -e(을)를 지정하면, Perl 스크립트가 직접 실행된다.
# -n(을)를 지정하면, Perl 스크립트가 while(<>){ } 로 둘러싸인 것이 된다.
#while(<>) {
#1. 인수로 주어진 파일의 각 행이,<>에게 건네진다.
#2. <>그리고 받은 각 행은, 루프 속에서,$_에게 건네진다.
#3. 정규 표현//에는,$_하지만 암묵적으로 이용된다 print의 인수에는, 암묵적으로$_하지만 이용된다.
# print if( /search/ );
#}

# -------------------------------------------------------------------
# v1
# perl oneliner-replace-config.pl
open(IN_FILE, "<"."inputfile.txt");
open(OUT_FILE, ">"."outputfile.txt");
while(<IN_FILE>) {
    if( /search/ ) {
        print OUT_FILE;
    }
}
close(IN_FILE);
close(OUT_FILE);

# -------------------------------------------------------------------
# v2
# perl oneliner-contain-filetext-v2.pl inputfile.txt > outputfile.txt
while(<>){ # ←인수로 주어진 파일의 각 행이,<>에게 건네진다. # <>그리고 받은 각 행은, 루프 속에서,$_에게 건네진다.
    print if( /search/ ); # ←정규 표현//에는,$_하지만 암묵적으로 이용된다 # print의 인수에는, 암묵적으로$_하지만 이용된다.
}
