#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

NUMBER=$(( RANDOM % 1000 + 1 ))
GUESSES=0

echo "Enter your username:"
read USERNAME

USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USERNAME'")


if [[ -z $USER_ID ]]
  then
    echo "Welcome, $USERNAME! It looks like this is your first time here."
    USER_ID=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME') RETURNING user_id" | head -1)
else 
   GAMES=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id=$USER_ID")
  BEST=$($PSQL "SELECT MIN(guesses_count) FROM games WHERE user_id=$USER_ID")

  echo "Welcome back, $USERNAME! You have played $GAMES games, and your best game took $BEST guesses."
fi

GAME_ID=$($PSQL "INSERT INTO games(user_id, secret_number, guesses_count) VALUES($USER_ID, $NUMBER, 0) RETURNING game_id" | head -1)


echo "Guess the secret number between 1 and 1000:"

while true
  do
  read GUESS

  if ! [[ $GUESS =~ ^[0-9]+$ ]]
    then
    echo "That is not an integer, guess again:"
    continue
  fi

  (( GUESSES++ ))

  if [[ $GUESS -eq $NUMBER ]]
    then
    echo "You guessed it in $GUESSES tries. The secret number was $NUMBER. Nice job!"
    $PSQL "UPDATE games SET guesses_count=$GUESSES WHERE game_id=$GAME_ID" > /dev/null

    break
  elif [[ $GUESS -gt $NUMBER ]]
    then
    echo "It's lower than that, guess again:"
  else
    echo "It's higher than that, guess again:"
  fi
done
