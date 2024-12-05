# sultan
A universal, multi-paradigm programming language designed for simplicity, flexibility, and efficiency, and support for writing code in any spoken language.

# Building Sultan lang
Before running 
```sh
./build.sh
```
make sure you have installed for non ARM system or Mac os
```sh
#install ocaml
sudo apt install ocaml
#install ocaml opam
sudo apt install opam
# start init
opam init
#set env
eval $(opam env)
# install utf8
opam install uutf
```
For ARM system and Mac os
```sh
#Install Homebrew if you haven't already:
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install ocamlc
brew install ocaml
# install opam
brew install opam
# init opam
opam init
# set env
eval $(opam env)
# install utf8
opam install uutf
```
ones thats done then run
```sh
./build.sh
```



# Use Sultanc
```sh
cd compiler
```
You will have ./sultanc 
sultan files are .sn 
```sh
# use case ./sultanc <filename.sn>
./sultanc example.sn
```

```
#it is an example of sultanc
let: x int :=1;
# in for beta testing we found this better will be
let x: int =1;
# and using the : for reassignment for example
# x is 1
let x: int = 1;
# reassignment x to 2
x:=2;
#  why is that need to change? simply to to make  the reassignment easier, and we can do
let x: int const=1;
#which the vaule x is immutable be declaring const. 
# this are the goals for the next beta testing.
# so we can do for mutable
let x: int 1;
```





