#!/bin/bash
make
echo "**************************start copy from this line**************************"
echo "***basic test:"
./a.out << 'EOF'
5
hello
5
world
60
EOF
./a.out << 'EOF'
5
hello
3
bye
52
e z
EOF
./a.out << 'EOF'
5
hello
3
bye
52
z a
EOF
./a.out << 'EOF'
5
hello
5
world
53
1
4
EOF
./a.out << 'EOF'
5
He@lo
5
WORLD
54
EOF
./a.out << 'EOF'
5
hello
5
world
55
1
10
EOF
./a.out << 'EOF'
5
hello
5
world
78
EOF
echo "***test opt 50 & 60:"
echo "opt50or60.1:"
./a.out << 'EOF'
0

0

50
EOF
echo "opt50or60.2:"
./a.out << 'EOF'
127
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab
127
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab
60
EOF
echo "opt50or60.3:"
./a.out << 'EOF'
0000000000000000000000000000000001
e
0000000000000000000000000000000001
o
50
EOF
echo "opt50or60.4:"
./a.out << 'EOF'
16
!@#$%^&*()_+/*-|
21
a!@#V45ghksi^,kfl#fhj
60
EOF
echo "opt50or60.5:"
./a.out << 'EOF'
00000000000000000000000022
!@#$%dsioa!@#$djk2@#$%
00000000000000015
a#AD@$ddg#$^%Gb
50
EOF
echo "***test opt 52:"
echo "opt52.1:"
./a.out << 'EOF'
0

0

52
a b
EOF
echo "opt52.2:"
./a.out << 'EOF'
127
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab
127
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab
52
a C
EOF
echo "opt52.3:"
./a.out << 'EOF'
0000000000000000000000000000000001
e
0000000000000000000000000000000001
o
52
e p
EOF
echo "opt52.4:"
./a.out << 'EOF'
16
!@#$%^&*()_+/*-|
21
a!@#V45ghksi^,kfl#fhj
52
f %
EOF
echo "opt52.5:"
./a.out << 'EOF'
00000000000000000000000022
!@#$%dsioa!@#$djk2@#$%
00000000000000015
a#AD@$ddg#$^%Gb
52
@ 5
EOF
echo "opt52.6:"
./a.out << 'EOF'
10
A 45 $ h H98.5
10
f    45f    jk5545
52
5 .
EOF
echo "***test opt 53:"
echo "opt53.1:"
./a.out << 'EOF'
0

0

53
0
0
EOF
echo "opt53.2:"
./a.out << 'EOF'
127
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab
127
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccd
53
0
126
EOF
echo "opt53.3:"
./a.out << 'EOF'
0000000000000000000000000000000001
e
0000000000000000000000000000000001
o
53
0
0
EOF
echo "opt53.4:"
./a.out << 'EOF'
16
!@#$%^&*()_+/*-|
21
a!@#V45ghksi^,kfl#fhj
53
5
15
EOF
echo "opt53.5:"
./a.out << 'EOF'
00000000000000000000000022
!@#$%dsioa!@#$djk2@#$%
00000000000000015
a#AD@$ddg#$^%Gb
53
0
8
EOF
echo "opt53.6:"
./a.out << 'EOF'
10
A 45 $ h H98..
10
f    45f    jk5545
53
9
9
EOF
echo "opt53.7:"
./a.out << 'EOF'
0

0

53
-128
-128
EOF
echo "opt53.8:"
./a.out << 'EOF'
5
asdfg
3
qwe
53
3
3
EOF
echo "opt53.9:"
./a.out << 'EOF'
8
qwertyui
8
54123698
53
-128
7
EOF
echo "opt53.10:"
./a.out << 'EOF'
8
qwertyui
8
54123698
53
0
8
EOF
echo "***test opt 54:"
echo "opt54.1:"
./a.out << 'EOF'
0

0

54
EOF
echo "opt54.2:"
./a.out << 'EOF'
127
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab
127
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccd
54
EOF
echo "opt54.3:"
./a.out << 'EOF'
0000000000000000000000000000000001
e
0000000000000000000000000000000001
o
54
EOF
echo "opt54.4:"
./a.out << 'EOF'
16
!@#$%^&*()_+/*-|
21
a!@#V45ghksi^,kfl#fhj
54
EOF
echo "opt54.5:"
./a.out << 'EOF'
00000000000000000000000022
!@#$%dsioa!@#$djk2@#$%
00000000000000015
a#AD@$ddg#$^%Gb
54
EOF
echo "opt54.6:"
./a.out << 'EOF'
26
abcdefghijklmnopqrstuvwxyz
26
ABCDEFGHIJKLMNOPQRSTUVWXYZ
54
EOF
echo "opt54.7:"
./a.out << 'EOF'
26
aBcDeFgHiJkLmNoPqRsTuVwXyZ
26
AbCdEfGhIjKlMnOpQrStUvWxYz
54
EOF
echo "opt54.8:"
./a.out << 'EOF'
52
a!#$%^BcDe@#%^&FgHiJ#@$%^kLmNoPq!#$^%$*RsTuVw@#%$XyZ
47
Ab!#%CdEfG!@#@%hIj!%$KlMnOpQr!$^%$&StUvW3425xYz
54
EOF
echo "***test opt 55:"
echo "opt55.1:"
./a.out << 'EOF'
0

0

55
0
0
EOF
echo "opt55.2:"
./a.out << 'EOF'
127
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab
127
ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccd
55
0
126
EOF
echo "opt55.3:"
./a.out << 'EOF'
0000000000000000000000000000000001
e
0000000000000000000000000000000001
o
55
0
0
EOF
echo "opt55.4:"
./a.out << 'EOF'
16
!@#$%^&*()_+/*-|
21
a!@#V45ghksi^,kfl#fhj
55
2
8
EOF
echo "opt55.5:"
./a.out << 'EOF'
00000000000000000000000022
a@#$%dsioa!@#$djk2@#$%
00000000000000015
a#AD@$ddg#$^%Gb
55
0
14
EOF
echo "opt55.6:"
./a.out << 'EOF'
127
abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvx
127
abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvx
55
0
126
EOF
echo "opt55.7:"
./a.out << 'EOF'
127
abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuva
127
abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvz
55
0
126
EOF
echo "opt55.8:"
./a.out << 'EOF'
127
abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvz
127
abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuva
55
0
126
EOF
echo "opt55.9:"
./a.out << 'EOF'
127
abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvz
127
abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuva
55
15
88
EOF
echo "opt55.10:"
./a.out << 'EOF'
127
abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvz
127
abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzabcdefghijklmnopqratuva
55
14
122
EOF
echo "opt55.11:"
./a.out << 'EOF'
38
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%^
40
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A00
55
8
37
EOF
echo "opt55.12:"
./a.out << 'EOF'
38
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%^
40
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%a00
55
8
37
EOF
echo "opt55.13:"
./a.out << 'EOF'
38
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A
40
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A00
55
8
37
EOF
echo "opt55.14:"
./a.out << 'EOF'
38
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A
40
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A00
55
8
38
EOF
echo "opt55.15:"
./a.out << 'EOF'
38
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A
40
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A00
55
-128
0
EOF
echo "opt55.16:"
./a.out << 'EOF'
38
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A
40
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A00
55
-1
5
EOF
echo "opt55.17:"
./a.out << 'EOF'
40
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A00
38
!@#$%^&*()+_)(*&^%$#@$%^)51AASFVHI@$%A
55
8
38
EOF
echo "***test other opt:"
echo "otherOpt.1:"
./a.out << 'EOF'
0

0

51
EOF
echo "otherOpt.2:"
./a.out << 'EOF'
0

0

56
EOF
echo "otherOpt.3:"
./a.out << 'EOF'
0

0

57
EOF
echo "otherOpt.4:"
./a.out << 'EOF'
0

0

58
EOF
echo "otherOpt.5:"
./a.out << 'EOF'
0

0

59
EOF
echo "otherOpt.6:"
./a.out << 'EOF'
0

0

-128
EOF
echo "otherOpt.7:"
./a.out << 'EOF'
0

0

32754
EOF
echo "otherOpt.7:"
./a.out << 'EOF'
0

0

-14
EOF

echo "***other tests:"
echo "other.1:"
./a.out << 'EOF'
50
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab
50
ccccccccccccccccccccccccccccccccccccccccccccccccco
53
-113
49
EOF

echo "other.2:"
./a.out << 'EOF'
50
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaab
50
ccccccccccccccccccccccccccccccccccccccccccccccccco
55
-113
49
EOF
echo "**************************copy until this line**************************"