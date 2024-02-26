# 2024-group-4

![](asset/mmexport1708947640736.jpg)

Kevin Chen   ad23091@bristol.ac.uk   ad23091

Xiaokang Fan dr23824@bristol.ac.uk   SeventyThree73

Tianyi Chen fu23287@bristol.ac.uk    TYChen2000

Nicky Dickson kr23498@bristol.ac.uk   nd1221

# Game ideas:

1.
Name: Vampire Survivors
   
Description: It is an action roguelike game, in this game, players need to survive while encountering an evolving horde of monsters in a select time; eliminating monsters can provide experience for players to level up which will provide several choices for players to choose, like upgrade a old weapon, add a new weapon or add a buff to the player; before the game is started, the player can choose a weapon to start; there will be 3 modes for the player to choose: easy, middle, hard.
   
Challenges: how to create an evolving horde of monsters? how to design different weapons? how to balance the game difficulty and the fun of playing the game?

2.
Name: Defend Zombies

Description: In Defend Zombies, players take on the role of a gardener using a variety of plants to protect their home from an ever-evolving zombie horde. The game is set during the day in a swimming pool, with waves and types of zombies evolving and increasing over time. Players need to flexibly deploy plants, upgrade strategies, and use special props to defend against zombies. As players progress, they can unlock more plant species and upgrades to face greater challenges.

Challenge: How to design unique zombies? How to design different defense towers? How to balance game difficulty and fun of playing the game?

3.
Name: Grand Strategy Chess

Description: In "Grand Strategy Chess", players will play the role of generals from different historical periods and command their armies to fight on a map composed of checkerboards. Each checkerboard represents a different terrain, such as plains, mountains, forests, and rivers, and each terrain will have an impact on the outcome of the battle. Players need to use strategic deployment, troop matching and terrain utilization to defeat their opponents and win.

Core gameplay:
Strategic deployment: Before the war, players need to deploy their own troops according to the opponent's arms and the terrain of the map, and reasonably arrange the positions of infantry, cavalry, archers and special units.
Combination of arms: Different arms have their own advantages and disadvantages on different terrains. Players need to choose the most appropriate combination of arms based on the battlefield environment and the opponent's strategy.
Terrain utilization: Use the advantages of the terrain to deploy defense or attack. For example, defending in mountains can greatly reduce the enemy's attack power, and ambush beside a river can limit the enemy's movement.
Tactical change: Players can adjust tactics according to changes in the situation during the battle, such as switching from defense to offense, or using special units to conduct surprise attacks.

Game features:
Rich types of arms and units: Provides a variety of different types of arms and special units, each with its own unique skills and combat style.

Design challenges:
Balance: Ensure that all classes, special units, and terrain effects are balanced in the game, whether in single-player campaigns or multiplayer battles.
Strategic Depth: Designing mechanics and tactical possibilities that are complex enough to satisfy players of all skill levels while keeping the game accessible.
Map and campaign diversity: Create rich and diverse maps and campaign stories to increase the replay value of your game.

4.
Name: Maze Tank Blitz

Description: In "Maze Tank Blitz", players will drive tanks to fight in a maze full of obstacles and traps. The goal of the game is to use your tank's cannon and special abilities to defeat your enemies while avoiding the maze's traps and enemy attacks. The game offers multiple different maze maps, each with unique designs and challenges. Players can fight alone or with friends in split-screen or online multiplayer modes.

Core gameplay:
Maze exploration: Players need to find the best path in a complex maze to attack enemies while avoiding being discovered and attacked by enemies.
Combat and Strategy: Take advantage of the maze's environment and design to defeat your opponents through strategic deployment and quick reactions.
Upgrades and Customization: After defeating enemies, players can collect resources to upgrade their tanks, including increased firepower, defense, and speed.
Multiplayer mode: supports multiplayer battles and provides an exciting PVP experience.

Game features:
Dynamic Maze System: The layout of the maze is randomly generated each time you play, providing players with an ever-changing challenge and exploration experience.
Diverse equipment: Provides a variety of weapon options, each with its own characteristics and tactical value.
Special abilities and props: Players can find or earn special abilities and props in the maze, such as invisibility cloaks, speed acceleration, and powerful cannonballs, adding more variables to the battle.

challenges:
Balance: Ensure balance between all weapons to make the game both fair and challenging.
Maze generation algorithm: Design an algorithm that can generate fair and interesting maze layouts to provide a diverse gaming experience.

5.
Name: Reimagining of Pac-Man
   
Description: The original Pac-Man is a  classic arcade game that was created by Namco in 1980. It features a yellow, circular character that moves around a maze, eating dot and avoiding ghosts.

Twist: In our version of Pac-Man, both the character and the ghost will be controled by AI, and the player's task is to build blocks to keep the ghosts away from the character and all the dots that are eaten by the character will become money which can be used to buy more blocks, and there are different kinds of blocks that can be bought which have different abilities like transport the character or stop the ghost for a while.
   
Challenges: how to create different kinds of blocks? how to design the AI for the character and the ghost? how to balance the game difficulty?


6.
Name: Hollow Knight clone

Description: Metroidvania-style platformer puzzle game where the player must navigate through a dungeon, avoiding obstacles and killing enemies. 

Twist: The player’s peripherals have limited use (e.g. can only move forward x squares, limited mouse presses) and in order to reach the end of the dungeon, they must collect ‘peripheral’ tokens to allow them to continue. If they run out of moves, the game ends.

Challenges: tedious to design levels which strike right balance between playable and frustrating, must design by anticipating how the player chooses to use their available moves, using a generative map to avoid hand-designing levels, extra challenges stemming from generative map are how to generate peripheral tokens and enemies in the right place to make the game playable.

# Requirements

## Stakeholders

* Users of the game
* The markers of the project

## User Storeies

As a player, I want to choose different modes of the game so that I can choose the game's difficulty based on my requirements.

As a player, I want to gain resources through some special behviours in the game, and these resources can be able to trade for different blocks, so it is bit more fun.

As a player, I want to know the direction of my character, so that I can know where it will go.

As a player, I want to have cases or tutorial examples telling me some of special designs of the game.

As a marker for this project, I want to see groups create engaging and well made games, with a good twist that is interesting, and a strong process of development that utilises the techniques taught in this module.

## Use-case specifications

| Use-Case Section                        | 2 players vs Computer                                      | 1 player vs Computer                                                                                                     |
|-----------------------------------------|-----------------------------------------------|-----------------------------------------------------------------------------------------------------------------|
| **Description**                         | 1 player play the blocker 1 player play the pacman against 4 ghosts play by the computer     | player play the blocker,one computer play the pacman, against 4 ghosts play by the computer                                             |
| **Basic Flow**                          | Ghosts need to catch the pacman, blocker need to stop that                    | Ghosts need to catch the pacman, blocker need to stop that                                          |
| 1.                                      | Players can choose to be the blocker or the pacman, Players can choose the difficulty, which will change the abilities of the ghost | Players can choose the difficulty, which will change the abilities of the ghost                                          |
| 2.                                      | Blocker LEFT-CLICK and drag the block to place blocks if the money is enough; the other player use WASD to control the pacman's move | Blocker LEFT-CLICK and drag the block to place blocks if the money is enough|
| 3.                                      | Game ends                                  | Game ends                                                                     |
|                                         |                                               |                                                                                                                 |
| **Alternative Flow**                    |                                               |                                                                                                                 |
| A1                                      | 1. Pacman eats a dot, the blocker's money increase by 1                                |                                                                                                                 |
|                                         | 2. Back to Basic Flow 1.                    |                                                                                                                 |
| A2                                      | 1. Pacman eats all the dots                                    |                                                                                                                 |
|                                         | 2. Back to Basic Flow 3.                    |                                                                                                                 |
| A3                                      | 1. Blocker purchases a block and place it                                    |                                                                                                                 |
|                                         | 2. Back to Basic Flow 1.                    |                                                                                                                 |
| A4                                      | 1. Ghost catch the pacman                           |                                                                                                                 |
|                                         | 2. Back to Basic Flow 3.                    |                                                                                                                 |
=======

* 1 player or 2 players

* then settings screen
    * choose side for the two players or choose the difficulty of the game
    * show some examples of how to play the game
    * choose the map of the game

* game starts 

* Final screen: Pacman / Ghosts win


## Use-case diagram

TODO

## Reflection

TODO

## Class Diagram

![Pacman Class Diagram.png](https://s2.loli.net/2024/02/19/6fTRoFiNHIDz4JB.png)

## Works Division before 3.11
1. Start menu // Tianyi Chen
2. End Scene // Tianyi Chen
3. Highscore record // Kane
4. Ghost's movement logic // Nicky
5. Pacman's movement logic // Juean Chen
6. Block's design // Juean Chen
7. Collision logic // Kane
