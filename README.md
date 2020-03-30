# SuperTicTacToe
A game of TicTacToe with a twist - personal learning project for iOS

This is a personal development project/porfolio project I am currently working on to develop my Swift capabilities

Please keep in mind while looking at the project that it is still a work in progress.

Currently on the to-do list as I have time:

1) music and sound effects
2) add in camera support for player profiles.
3) wire up the search field in the player select screen so that a person can search for a specific profile


Synopsis:
This project is an extension of a final project I originally wrote in Java for school. There is a standard mode for a 
plain vanilla game of TicTacToe and a super mode. In super mode each player has access to a super power
which they can use once per game.

The super powers are:

Freeze - Player can freeze one tile for a turn. It will unfreeze at the beginning of that players next turn.

Swap - Player can choose one of their tiles and it will randomly be swapped with one of their opponents tiles.

Rewind - When activated Rewind undoes both players last moves, effectively stepping the game back a turn.

The app also has the ability to create player profiles, which will track win/loss stats (in a future build) and allow the player
to select which power they want to use. There are currently 5 generic profiles permanently embedded, one for each of the
super powers as well as generic Player1/Player2 profiles, which when selected will randomly select one of the powers at the start
each game.
