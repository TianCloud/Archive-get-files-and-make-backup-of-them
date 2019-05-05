Description:

	archive [-s size] [-S sDir] [-d dDir] < ext_list >

The script archive copies all files from source directory sDir (or current directory if this argument
is omitted), with extensions in < ext_list >, into destination directory dDir/backUp. If
option dDir is omitted, then sDir is also the destination directory. 

When option size is present, only files exceeding it are concerned by this operation. (not working properly)

Execution:

An example of running the Bash script:

	bash archive.sh -s anyNumber -d ~/someFile/ pdf doc exe

-s: with anyNumber indicate size of files
-d: indicate destination directory
pdf doc exe: file types
