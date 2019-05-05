#!/bin/bash

#created by Ruotian Liu, all rights reserved.

#setting up variables
temp=0
realsize=-1
realsDir=-1
realdDir=-1
comNum=$#
counter=0
thisArray=($@)

echo Here is what you have entered:
echo ${thisArray[@]}

echo Number of arguments entered: $comNum

#to check if options are given
#types of option:
# 1.file size
# 2.source directory
# 3.destination directory
for input in "$@"
do
	temp=$((temp+1))

	if [ "$input" == "-s" ] #size of file
       	then
		size=$((temp+1))
		realsize=${!size}
		size=$((size+1))
		let counter=counter+2
	fi
	if [ "$input" == "-S" ] #source directory
       	then
		sDir=$((temp+1))
		realsDir=${!sDir}
		sDir=$((sDir+1))
		let counter=counter+2
	fi
	if [ "$input" == "-d" ] #destination directory
       	then
		dDir=$((temp+1))
		realdDir=${!dDir}
		dDir=$((dDir+1))
		let counter=counter+2
	fi
done

#copy selected files to destination
#four cases: 
# 1. sDir and dDir are provided
# 2. only dDir is provided
# 3. only sDir is provided
# 4. none of Dir is provided
while [ $counter -lt $comNum ]
do
	#echo ${thisArray[$counter]}
	tempEXT=${thisArray[$counter]}


	if [ "$realsDir" != "-1" ] && [ "$realdDir" != "-1" ] #case 1
	then
		if [ -d "$realdDir/backUp" ]
		then
			cd $realsDir
			cp *.$tempEXT $realdDir/backUp
		else
			mkdir $realdDir/backUp
			cd $realsDir
			cp *.$tempEXT $realdDir/backUp
		fi
		flag=1
	elif [ "$realdDir" != "-1" ] && [ "$realsDir" == "-1" ] #case 2
	then
		if [ -d "$realdDir/backUp" ]
		then
			cp *.$tempEXT $realdDir/backUp
		else
			mkdir $realdDir/backUp
			cp *.$tempEXT $realdDir/backUp
		fi
		flag=2
	elif [ "$realsDir" != "-1" ] && [ "$realdDir" == "-1" ] #case 3
	then
		if [ -d "$realsDir/backUp" ]
		then
			cd $realsDir
			cp *.$tempEXT $realsDir/backUp
		else
			cd $realsDir
			mkdir backUp
			cp *.$tempEXT $realsDir/backUp
		fi
		flag=3
	elif [ "$realsDir" == "-1" ] && [ "$realdDir" == "-1" ] #case 4
	then
		if [ -d "backUp" ]
		then
			cp *.$tempEXT backUp
		else
			mkdir backUp
			cp *.$tempEXT backUp
		fi
		flag=4
	fi
	let counter=counter+1
done

#back up destination folder as zip file for each case
#and delete backUp folder
if [ "$flag" == "1" ] #when dDir and sDir are provided
then
	cd $realdDir
	tar -zcvf backUp.tar.gz backUp
	rm -rf backUp
elif [ "$flag" == "2" ] #when only dDir is provided
then
	cd $realdDir
	tar -zcvf backUp.tar.gz backUp
	rm -rf backUp
elif [ "$flag" == "3" ] #when only sDir is provided
then
	cd $realsDir
	tar -zcvf backUp.tar.gz backUp
	rm -rf backUp
elif [ "$flag" == "4" ] #when sDir and dDir are NOT provided
then
	tar -zcvf backUp.tar.gz backUp
	rm -rf backUp
fi
