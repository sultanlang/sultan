# sultan
A universal, multi-paradigm programming language designed for simplicity, flexibility, efficiency, and support for writing code in any spoken language.

# Building Sultan lang
Before running 
```sh
./boot.sh
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


```
ones thats done then run
```sh
./boot.sh
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

