if [ "$#" -ne 1 ]; then
    echo "Incorrect count of parameters: ./builder.sh <script_name>"
    exit 1
fi

cl=`eval clang++ -std=c++14 $1.cpp -o $1.b`