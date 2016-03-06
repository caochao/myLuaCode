gcc -Wall -c -I./luasrc ./MyCModule.c -o ./MyCModule.o
gcc -Wall -L. -llua MyCModule.o -o MyCModule.exe
:gcc -Wall -L. -llua MyCModule.o -fPIC -shared -o libMyCModule.so