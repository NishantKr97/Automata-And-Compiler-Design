bison -y -d yacc.y
flex yacc.l
gcc -c y.tab.c lex.yy.c
gcc -o scan lex.yy.o y.tab.o
./scan