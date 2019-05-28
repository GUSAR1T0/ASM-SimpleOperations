#!/bin/bash
cd ../csharp/
eval csc /t:exe /out:$1.b $1.cs utils.cs