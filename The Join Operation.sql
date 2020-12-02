/*1. The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER' */
SELECT matchid, player FROM goal 
  WHERE teamid='GER'

/*2. Show id, stadium, team1, team2 for just game 1012 */
SELECT id,stadium,team1,team2
  FROM game
where id= 1012

/*3.Modify it to show the player, teamid, stadium and mdate for every German goal. */
SELECT player,teamid, stadium, mdate
  FROM game JOIN goal ON 
game.id=goal.matchid
where teamid='GER'

/*4.Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%' */
select team1, team2, player
from goal join game
on goal.matchid=game.id
where player like 'Mario%'

/*5.The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id

Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10 */
SELECT player, teamid,coach, gtime
  FROM goal join eteam
on goal.teamid = eteam.id
 WHERE gtime<=10

/*6.List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach. */
select mdate, teamname
from game join eteam
on game.team1 = eteam.id
where coach = 'Fernando Santos'

/*7.List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw' */
select player
from goal join game
on goal.matchid= game.id
where stadium = 'National Stadium, Warsaw'

/*8.Instead show the name of all players who scored a goal against Germany. */
SELECT distinct(player)
  FROM game JOIN goal ON 
goal.matchid = game.id 
where teamid!= 'GER'
and (team1='GER' or team2='GER')

/*9.Show teamname and the total number of goals scored. */
SELECT teamname, count(*)
  FROM eteam JOIN goal ON 
eteam.id=goal.teamid
 group by teamname

/*10.Show the stadium and the number of goals scored in each stadium.*/
select stadium, count(*)
from game join goal
on game.id= goal.matchid
group by stadium

/*11. For every match involving 'POL', show the matchid, date and the number of goals scored. */
SELECT matchid,mdate, count(*)
  FROM game JOIN goal ON 
game.id = goal.matchid 
 WHERE (team1 = 'POL' OR team2 = 'POL')
group by matchid, mdate

/*12.For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER' */
select matchid, mdate, count(*)
from goal join game
on goal.matchid=game.id
where teamid='GER'
group by matchid, mdate

/*13.List every match with the goals scored by each team as shown. 
This will use "CASE WHEN" which has not been explained in any previous exercises.
mdate	team1	score1	team2	score2
1 July 2012	ESP	4	ITA	0
10 June 2012	ESP	1	ITA	1
10 June 2012	IRL	1	CRO	3
...
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. 
You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2. */
SELECT mdate,
       team1,
       SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
       team2,
       SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2 FROM
    game LEFT JOIN goal ON (id = matchid)
    GROUP BY mdate, matchid, team1,team2
    ORDER BY mdate, matchid, team1, team2    