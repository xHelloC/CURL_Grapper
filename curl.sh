#!/bin/bash

## Config ##
Your_CDN="Your_CDN_SERVER"
Your_URL="Your_Upload_Url"
_date_=$(date '+%Y-%m-%d %H:%M:%S')
_random_=$(cat /dev/urandom | env LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
#####################

## Colors ##
G="\e[32m"
R="\e[31m"
Y="\e[33m"
E="\e[0m" ## Make Default Color
#####################

echo -e "########### ${Y} File Downloader! ${E} ############## ${R}ver. 3.20 ${E}"
echo -e ""

## Read_Input ##
read -p 'Your Link to Provide: ' link

link="https://youtu.be/KUIdo-PLUgI"

if [[ "$link" == *"youtube"* ]] || [[ "$link" == *"youtu.be"* ]]; then
    format="mp4"
    path_temp="tmp/"
    ####
    ####
    Ytb_to="$(cd "$path_temp" && pytube $link)"

    if [[ "$Ytb_to" == *"100"* ]]; then
        r=$(find $path_temp -name *."$format")
        cp "$r" ytb/$_random_.$format
        rm -r "$r"
        echo -e "Unique  :   ${Y}$_random_ ${E}"
        echo -e "Link    :  ${Y} $Your_URL/ytb/$_random_.$format"
        echo -e "${E}"
        echo -e "${G}" && ls -la ytb/$_random_.$format && echo -e "${E}"
        echo -e "[$_date_] ${G}+ [YTB] ${E} ${Y} $_random_.$format ${E}"
        echo "[$_date_]+ [YTB]  $_random_.$format" >> CURL.log
        exit
    else
        echo -e ""
        echo -e "${R} Error! ${E}Video is already exist! ${Y} !! ${E}"
        echo -e ""
        exit
    fi
else
     read -p 'YourFolder to Upload: ' folder
     read -p 'Custom Format?: ' format
fi

if [ -z "$Your_URL" ] || [ -z "$link" ]; then
    clear
    echo -e ""
    echo -e ""
    echo -e ""
    echo -e ""
    echo -e ""
    echo -e "${R} Error! ${E}You don't have setup 'Your_URL or you don't give a correct ${Y}Link ${E}"
    echo -e ""
    echo -e ""
    echo -e ""
    echo -e ""
    echo -e ""
    exit
fi
###############################################################

## Application ##
_http_code_=$(curl -s -o /dev/null -w "%{http_code}" "$link")
_i_=$(basename -- $link)
_ext_="${_i_##*.}"
_done_="$_random_.$_ext_"
#########################################################################################################



## Main ##

echo -e "${Y}* ${E}- Checking if is available"
sleep 2
if [ "$_http_code_" -ne "404" ] || [ "$_http_code_" -ne "500" ]; then
    _status_="true"
else
    _status_="false"
fi

## Folder Exist ##
if [ "$_status_" == "true" ]; then
    if [ -z "$folder" ]; then
        _new_="$_done_"
    else
        if [ -d "$folder" ]; then
            if [ -z "$format" ]; then
                _new_="$folder/$_done_"
            else
                _new_="$folder/$_random_.$format"
            fi
        else
            if [ -z "$format" ]; then
                mkdir $folder
                _new_="$folder/$_done_"
            else
                _new_="$_random_.$format"
            fi
        fi
    fi
else
    echo -e "Status on remoted page is ${R} 404 or 500 ${E}"
fi
##

## Execute ##
if [ "$_status_" == "true" ]; then
    clear
    echo -e "\n${G} Uploading \n"
    sleep 1
    curl -s -o "$_new_" "$link"

    if [[ -f "$_new_" ]]
    then
        echo -e "Unique  :   ${Y}$_random_ ${E}"
        echo -e "New File:   $_new_ ${E}"
        echo -e "Link    :  ${Y} $Your_URL/$_new_"
        echo -e "${E}"
        echo -e "${G}" && ls -la $_new_ && echo -e "${E}"
        echo -e "[$_date_] ${G}+${E} ${Y}$_new_ ${E}"
        echo "[$_date_] + $_new_" >> CURL.log
    else
        echo -e "\n File ${Y} $_new_ ${E}Cannot be Uploaded! | Return code is ${R} 404/500 ${E}"
    fi
fi

############################################



