#!/bin/bash

if [ ! `which drush` ];then
  echo "Please install drush first, see http://docs.drush.org/en/master/install/ \n\n"
  exit 1
fi

if [ ! `which docker` ];then
  echo "Please install docker first, see http://docs.drush.org/en/master/install/ \n\n"
  echo "Linux see:  "
  echo "Windows see:  "
  echo "Mac see: https://docs.docker.com/engine/installation/mac/ \n\n"
  exit 1
fi

if [ ! `which docker-compose` ];then
  echo "Please install drush first, see http://docs.drush.org/en/master/install/ \n\n"
  exit 1
fi

if grep -Fxq "docker-compose stop; sleep 1; docker-compose up" ~/.drush/drushrc.php
then
  echo "shell-aliases found in your ~/.drush/drushrc.php"
else
  # Add docker commands to your drushrc.php
  cat drushrc.php >>~/.drush/drushrc.php
  echo "drushrc.php is added to your existing ~/.drush/drushrc.php"
fi


while true; do
    read -p "Do you wish to install drupal 7, latest version?" yn
    case $yn in
        [Yy]* ) drush dl drupal-7 --drupal-project-rename=docroot; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo "you can start the docker containers with the drush shell-aliases"
echo "to see all possible shell-aliases: drush sha"
echo "drush can be used in de host environment, directory $(pwd)/docroot"
echo "... or in the container: drush dexec\n"
echo "Have fun :)\n"
