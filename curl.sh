#!/bin/bash

## Config ##
Your_CDN = ""
Your_URL = ""
#####################

## Colors ##
G = "\e[32m"
R = "\e[31m"
Y = "\e[33m"
E = "\e[0m" ## Make Default Color
#####################

## Read_Input ##
read -p 'YourFolder to Upload: ' folder
read -p 'Your Link to Provide: ' link
read -p 'Custom Format?: ' format
###############################################################

## Application ##
_date_      = $(date '+%Y-%m-%d %H:%M:%S')
_random_    = $(cat /dev/urandom | env LC_ALL=C tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
_http_code_ = $(curl -s -o "l.log" -w "%{http_code}" "$link")
#########################################################################################################

## Main ##

