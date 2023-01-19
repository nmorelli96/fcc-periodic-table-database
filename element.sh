#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
else
#if the argument is a number
  if [[ $1 =~ ^[0-9]+$ ]] 
  then 
    PROPERTIES=$($PSQL "SELECT * FROM PROPERTIES FULL JOIN types USING(type_id) FULL JOIN elements USING(atomic_number) WHERE atomic_number=$1;") 
    if [[ -z $PROPERTIES ]]
    then
      echo I could not find that element in the database.
    else
      echo "$PROPERTIES" | while read ATOMIC_NUMBER BAR TYPE_ID BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE BAR SYMBOL BAR NAME
      do
        echo The element with atomic number $1 is $NAME \($SYMBOL\). It\'s a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius.
      done
    fi
#if the argument is a string
  else
    PROPERTIES=$($PSQL "SELECT * FROM PROPERTIES FULL JOIN types USING(type_id) FULL JOIN elements USING(atomic_number) WHERE symbol = '$1' OR name = '$1';") 
    if [[ -z $PROPERTIES ]]
    then
      echo I could not find that element in the database.
    else
      echo "$PROPERTIES" | while read ATOMIC_NUMBER BAR TYPE_ID BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR TYPE BAR SYMBOL BAR NAME
      do
        echo The element with atomic number $ATOMIC_NUMBER is $NAME \($SYMBOL\). It\'s a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT_CELSIUS celsius and a boiling point of $BOILING_POINT_CELSIUS celsius.
      done
    fi
  fi
fi
