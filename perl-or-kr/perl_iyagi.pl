use warnings;
use strict;

print "HELLO WORLD\n"; # hello world

# \t 탭
# \n 개행문자. 커서를 다음 줄 앞으로 보냄.
# \r 커서를 현 라인의 맨 앞으로 보냄.
# \f form feed
# \v vertical tab, whatever that is
# \b backspace
# \a alarm (bell) 삐이.
# \e escape
# \033 octal char
# \x1b hex char
# \c[ control char
# \l lowercase next char
# \u uppercase next char
# \L lowercase till \E
# \U uppercase till \E
# \E end case modification
# \Q quote regexp metacharacters till \E

# $
print "SCALAR ========================================\n";
my $price = 1000;
print "$price \n"; # 1000

$price = "very expensive.";
print "$price \n"; # very expensive.

# warning : Argument "very expensive." isn't numeric in multiplication (*)
print $price * 2 . "\n"; # 0

$price = 90;
my $double = $price * 2;
print "$double \n"; # 180

$price = "90";
my $double = $price * 2;
print "$double \n"; # 180

print "ARRAY ========================================\n";
# array
my @array = (2, 4, 6, 8, 10);
print "@array\n";              # 2 4 6 8 10
print "last index $#array \n"; # last index 4
print $array[1] . "\n";        # 4

my $size = @array;
print "$size\n"; # 5

print "HASH ========================================\n";
# hash
my %hash = ("k", 3, "j", 7, "l", 5, "m", 6);
print "%hash\n";         # %hash
print %hash;             # j7k3m6l57
print $hash{"j"} . "\n"; # 7
my $size = %hash;
print "$size\n"; # 4

print "PRINT ========================================\n";

print <<END_OF_HELLO;
Hello world.\n
I am here to serve you but not to conquer.
There were many kings and queens in the world,
but I want to be a real friend of yours.
END_OF_HELLO
print "Ending our greeting\n";

print "STDIN ========================================\n";
print "Say yes or no : ";
# my $answer = <STDIN>;
my $answer = "<STDIN>";
chomp $answer; # $answer 뒤에 따라붙는 \n을 잘라냅니다.
if ($answer eq 'yes') {
    print <<EOY;
You said $answer.
I will keep going on.
EOY
}
else {
    print "You said 'No.'\n";
}

my $a = "H A C K E R ";
my $len = (length $a) - 1;

# How do I flush/unbuffer an output filehandle? Why must I do this?
# https://perldoc.perl.org/perlfaq5#How-do-I-flush%2funbuffer-an-output-filehandle%3f--Why-must-I-do-this%3f
$| = 1;
print "$a\r";
for (0 .. 3) {
    for (0 .. $len) {
        my $s1 = substr($a, 0, $_);
        my $s2 = substr($a, $_ + 1);
        print "$s2$s1\r";
        # sleep 1;
    }
}
print "\n";

print "SYSTEM COMMAND ========================================\n";
# ~와 함께 있는 `를 사용하면 시스템 명령으로 인식하여 실행
print `pwd` . "\n";
print `ls -al` . "\n";

print "CGI ========================================\n";
# pass CGI


print "OPERATOR ========================================\n";
# http://www.perl.or.kr/perl_iyagi/operators

### 증가 연산자
my $foo = undef;
print ++($foo = '99'), "\n"; # prints '100'
print ++($foo = 'a0'), "\n"; # prints 'a1'
print ++($foo = 'Az'), "\n"; # prints 'Ba'
print ++($foo = 'zz'), "\n"; # prints 'aaa'
print --($foo = 'zz'), "\n"; # prints '-1' ??????????????

### 감소 연산자(--)는 증가 연산자가 피우는 재주를 모릅니다.
# Perl 언어에서도 0은 거짓으로 보고 그외는 참으로 봅니다.


print "FILE ========================================\n";
# http://www.perl.or.kr/perl_iyagi/files
my $fileName = "file.pl";

# -e  파일이 존재하는가 ? (참이면 1, 거짓이면 0을 리턴합니다.)
# -z  파일 크기가 0인가 ?
# -s  파일이 0 아닌 크기를 갖는가 ? (파일의 크기를 리턴합니다.)
# -f  파일이 평범한 파일인가 ?
# -d  파일이름이 디렉토리인가 ?
# -T  파일이 텍스트 파일인가 ?
# -B  파일이 이진 파일인가 ?
# -M  파일이 생성된지 몇일이 되었는가 ? ( 0부터 시작 )

#  -d $fileName && die "$fileName ...";와 같음.
my $fileName = "./README.md";
if (-d $fileName) {
    die "$fileName is a directory.\n";
}

# die 함수는 메세지를 출력하고 프로그램 실행을 중단시킵니다.
-e $fileName || die "$fileName is not exist.\n";
-T $fileName || die "$fileName is not a text file.\n";

open(fileHandle, $fileName) || die "Cannot open $fileName.\n";
my @allLines = <fileHandle>; # 핸들을 통하여 모든 문자열을 배열로 읽어 들입니다. 파일이 너무 크면 좀 문제가 있겠죠.
close(fileHandle);

print @allLines; # 화면에 출력합니다.

open my $SARAN, '<', $fileName or die "Can't open $fileName: $!";
while (my $line = <$SARAN>) {
    print $line unless $line =~ /^\s/;
}
close $SARAN;
#---------------------------------------------------------
open(fileHandle, ">./perl-or-kr/file-w.html") || die "Failed opening.\n";
print fileHandle <<END_HTML;
<html>
<head><title>test of writing</title></head>
<body>
<h1>Test of writing file in PERL</h1>
Hello. I am writing something to a file.<P>
    Be careful to close the file after completion of writing.<P>
</body>
</html>
END_HTML

close(fileHandle);
#---------------------------------------------------------
opendir(dirHandle, ".") || die "Failed opening.\n";
my @files = readdir(dirHandle);
closedir dirHandle;
print @files; # 알아먹기 힘들게 프린트됩니다.
print "\n";

@files = <../*>;
#print "@files";  #배열이 치환될 때에 각 요소 사이에 공백이 하나씩 들어갑니다.
print "@files\n";
print "-----------------------\n";
my $count = 0;
foreach my $file (@files) {
    $count++;
    print $count . " : " . $file . "\n";
}
