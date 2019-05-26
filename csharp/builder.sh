if [ "$#" -ne 1 ]; then
    echo "Incorrect count of parameters: ./builder.sh <script_name>"
    exit 1
fi

cl=`eval csc /t:exe /out:$1.b $1.cs utils.cs`