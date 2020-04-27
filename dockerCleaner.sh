#!/bin/bash
# This script needs to cleans up linegering docker stuff on your dev machine

function removeDanglingImages(){
    echo "Remove Dangling images?"
    echo "yes/no ?"
    read userResponse
    if [[ $userResponse =~ ^(yes|Yes|Y|y|1)$ ]] ; then
        docker rm $(docker image ls --filter "dangling=true")
        if [[ $? -eq 0 ]]; then
            echo "Failed: Removing Dangling images"
        else
            echo "Success: Removed Dangling images"
        fi
    fi
}

function removeContainers(){
    echo "Remove all killed containers?"
    echo "yes/no ?"
    read userResponse
    if [[ $userResponse =~ ^(yes|Yes|Y|y|1)$ ]] ; then
        docker rm $(docker ps -aq)
        if [[ $? -eq 0 ]]; then
            echo "Failed: Removed all existing containers."
        else
            echo "Success: Removed all existing containers."
        fi
    fi
}

function killContainers(){
    echo "Clean all docker containers?"
    echo "yes/no ?"
    read userResponse
    if [[ $userResponse =~ ^(yes|Yes|Y|y|1)$ ]] ; then
        docker kill $(docker ps -aq)
        if [[ $? -eq 0 ]]; then
            echo "Failed: Killed all docker containers."
        else
            echo "Success: Killed all docker containers."
        fi


    fi
}

function executeScript(){
    removeDanglingImages
    killContainers
    removeContainers
}

# Run shell script process #
executeScript
