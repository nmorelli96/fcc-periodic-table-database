#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table --tuples-only -c"

PROPERTIES=$($PSQL "SELECT * FROM properties ORDER BY atomic_number") 
echo "$PROPERTIES" | while read ATOMIC_NUMBER BAR TYPE BAR ATOMIC_MASS BAR MELTING_POINT_CELSIUS BAR BOILING_POINT_CELSIUS BAR
do
  if [[ $ATOMIC_NUMBER != atomic_number ]]
  then
  # get type_id to insert
    TYPE_ID=$($PSQL "SELECT type_id FROM types WHERE type = '$TYPE'")
  # insert type_id into properties
    UPDATE_TYPE_ID_INTO_PROPERTIES_RESULT=$($PSQL "UPDATE properties SET type_id=$TYPE_ID WHERE type='$TYPE'")
  fi
done
  
  