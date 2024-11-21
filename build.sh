#!/bin/sh

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
NC="\033[0m"  # No Color

PATHCOMPILER="compiler/core"
build (){
    cd $PATHCOMPILER || { echo "${RED}Failed to enter $PATHCOMPILER${NC}"; exit 1; }
    echo -e "${GREEN}Building...${NC}"

    # Compile core modules
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c errorlog.ml || { echo "${RED}Failed to compile errorlog.ml${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c error.mli || { echo "${RED}Failed to compile error.mli${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c error.ml || { echo "${RED}Failed to compile error.ml${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c id.ml || { echo "${RED}Failed to compile id.ml${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c Symboltable.ml || { echo "${RED}Failed to compile SymbolTable.ml${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c ast.ml || { echo "${RED}Failed to compile ast.ml${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c binding.ml || { echo "${RED}Failed to compile binding.ml${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c import_detection.mli || { echo "${RED}Failed to compile import_detection.mli${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c import_detection.ml || { echo "${RED}Failed to compile import_detection.ml${NC}"; exit 1; }

    # Compile generated parser files
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c sparser.mli || { echo "${RED}Failed to compile sparser.mli${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c sparser.ml || { echo "${RED}Failed to compile sparser.ml${NC}"; exit 1; }

    # ocamllex slexer.ml || { echo "${RED}Failed to compile slexer.ml${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c slexer.ml || { echo "${RED}Failed to compile slexer.ml${NC}"; exit 1; }

    # Compile additional modules
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c driver.ml || { echo "${RED}Failed to compile driver.ml${NC}"; exit 1; }
    ocamlfind ocamlc -verbose -package uutf,dynlink,compiler-libs.common -linkpkg -I core -c main.ml || { echo "${RED}Failed to compile main.ml${NC}"; exit 1; }

    # Linking all modules
    echo "=> Linking all modules to create sultanc"
    ocamlfind ocamlc -verbose -o sultanc -package uutf,dynlink,compiler-libs.common -linkpkg \
    errorlog.cmo error.cmo id.cmo Symboltable.cmo ast.cmo binding.cmo \
    import_detection.cmo sparser.cmo slexer.cmo driver.cmo main.cmo || { 
        echo "${RED}Linking failed${NC}"; exit 1; 
    }
    mv sultanc ../ || { echo "${RED}Failed to move sultanc${NC}"; exit 1; }
    echo -e "${GREEN}Build completed successfully${NC}"

}


clean (){
    cd $PATHCOMPILER || { echo "${RED}Failed to enter $PATHCOMPILER${NC}"; exit 1; }
    echo -e "${GREEN}Cleaning...${NC}"
    rm -f *.cmo *.cmi *.o 
    cd ../ || { echo "${RED}Failed to enter ..${NC}"; exit 1; }
    rm -f sultanc
    echo -e "${GREEN}Clean completed successfully${NC}"
}



case "$1" in
    build)
        build
        ;;
    clean)
        clean
        ;;
    *)
        echo "Usage: $0 {build|clean}"
        exit 1
esac