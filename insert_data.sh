#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read  YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
WINNER_ID=$($PSQL "SELECT team_id from teams WHERE name='$WINNER'")
WINNER_NAME=$($PSQL "SELECT name from teams WHERE name='$WINNER'")
if [[ $WINNER != winner ]]
then
if [[ $WINNER != $WINNER_NAME ]]
then 

INSERT_NAMES=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

echo $WINNER
echo $WINNER_ID
#echo "added winner name:$INSERT_NAMES"

fi
OPPONENT_NAME=$($PSQL "SELECT name from teams WHERE name='$OPPONENT'")
if [[ $OPPONENT != $OPPONENT_NAME ]]
then 
INSERT_NAMES=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
OPPONENT_ID=$($PSQL "SELECT team_id from teams WHERE name='$OPPONENT'")
echo $OPPONENT
echo $OPPONENT_ID
#echo "added opponent name:$INSERT_NAMES"
fi
INSERT_WINNER_GOALS=$($PSQL "INSERT INTO games(year,round,winner_goals,opponent_goals,winner_id,opponent_id) VALUES($YEAR,'$ROUND',$WINNER_GOALS,$OPPONENT_GOALS,$WINNER_ID,$OPPONENT_ID)")
echo $INSERT_WINNER_GOALS
fi

done


