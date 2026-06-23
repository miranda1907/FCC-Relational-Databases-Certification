if [[ -z $1 ]]
then
echo "Please provide an element as an argument."

else

  PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"


  if [[ $1 =~ ^[0-9]+$ ]]
  then
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ATOMIC_NUMBER")
  TYPE=$($PSQL "SELECT type FROM properties JOIN types USING(type_id) WHERE atomic_number=$1")
  MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")

  elif [[ $1 =~ ^[A-Za-z]{1,2}$ ]]
  then
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE LOWER(symbol)=LOWER('$1')")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE LOWER(symbol)=LOWER('$1')")
  NAME=$($PSQL "SELECT name FROM elements WHERE LOWER(symbol)=LOWER('$1')")
  TYPE=$($PSQL "SELECT type FROM properties JOIN types USING(type_id) JOIN elements USING(atomic_number) WHERE LOWER(symbol)=LOWER('$1')")
  MASS=$($PSQL "SELECT atomic_mass FROM properties JOIN elements USING(atomic_number) WHERE LOWER(symbol)=LOWER('$1')")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties JOIN elements USING(atomic_number) WHERE LOWER(symbol)=LOWER('$1')")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties JOIN elements USING(atomic_number) WHERE LOWER(symbol)=LOWER('$1')")


  elif [[ $1 =~ ^[A-Za-z]{3,}$ ]]
  then
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE LOWER(name)=LOWER('$1')")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE LOWER(name)=LOWER('$1')")
  NAME=$($PSQL "SELECT name FROM elements WHERE LOWER(name)=LOWER('$1')")
  TYPE=$($PSQL "SELECT type FROM properties JOIN types USING(type_id) JOIN elements USING(atomic_number) WHERE LOWER(name)=LOWER('$1')")
  MASS=$($PSQL "SELECT atomic_mass FROM properties JOIN elements USING(atomic_number) WHERE LOWER(name)=LOWER('$1')")
  MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties JOIN elements USING(atomic_number) WHERE LOWER(name)=LOWER('$1')")
  BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties JOIN elements USING(atomic_number) WHERE LOWER(name)=LOWER('$1')")

  fi

  if [[ -z $ATOMIC_NUMBER ]]
  then 
    echo "I could not find that element in the database."

  else 
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."

fi
fi
