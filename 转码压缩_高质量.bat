
echo off
echo ""
echo "****************************************************************"
echo "    all .mpg files under .\input                                "
echo "    will be transcoded into mp4 format,                         "
echo "    and output to directory .\output!                           "
echo "****************************************************************"
echo ""
pause

for %%i in (input\*.mpg) do (
	echo Input  file name is %%i	
	
	for /f "tokens=2 delims=\" %%j in ("%%i") do (
		echo j is %%j
		
		for /f "tokens=1 delims=.mpg" %%k in ("%%j") do (
			echo k is %%k
		    .\bin\ffmpeg -i "%%i"  -c:v libx264  -profile:v main  -level 40 -qmin 24 -qmax 40  -y  "output\%%k.mp4"
		)
	)
		
)
echo ""
echo "****************************************************************"
echo "    all mpg files in iput directory have been transcoded        "
echo "    into mp4 format, please check all output files under        "
echo "    directory .\output                                          "
echo "****************************************************************"
echo ""
pause