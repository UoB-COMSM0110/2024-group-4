## Game Video Link: https://youtu.be/6X-PJXRcBWU

## PART 1: TEAM 
### 2024-group-4
<div align=center>
   <img src="asset/2024_GROUP_4.JPG"/>
</div>

Juean Chen   ad23091@bristol.ac.uk   ad23091

Xiaokang Fan   dr23824@bristol.ac.uk   SeventyThree73

Nicky Dickson   kr23498@bristol.ac.uk   nd1221

---

## PART 2: INTRODUCTION

### Game Name: Pac-Man Savior 

<div align=center>
   <img src="asset/StartMenu.png"/>
</div>

### Game Introduction

Our game is a redesign of the classic Pac-Man created by Namco in 1980 featuring an added twist. Just as in the original, the goal remains for Pacman to travel across the game map, eating pellets and avoiding ghosts. However, in the original, the player has direct control of pacman and is free to decide where and how Pacman should move. In our version, the player has no control whatsoever, they are only allowed to manipulate the map itself by strategically placing blocks to block certain paths Pacman or the ghosts may take acting as a saviour-slash-personal-assistant to Pacman. Both the ghosts' and Pacman's movements are AI controlled and the player's job is to guide Pacman towards his goal of eating all pellets in the map whilst making sure the ghosts stay clear. With every pellet eaten, the player receives a payment which can be spent to purchase extra blocks or blocks with special abilities.

We identified a series of challenges in making such a game. These included how to design and program different kinds of blocks, how to design the AI for the character and the ghosts and how to balance the game difficulty.

---

### Ideation:

To begin with, we decided to come up with two ideas individually then meet in person to present them to each other and pick two from the pool of six to explore further. After a quick vote, we settled on a Vampire-Survivor-style game and a Pacman-style game (which was presented twice). To determine which idea we should pursue further, we conducted requirements engineering practices for both games: identifying stakeholders, specifying system behaviour through use case diagrams and specifications, and creating paper prototypes for boths games.

### Other Game Ideas

**1. Vampire Survivors**
   
_Description:_
An action roguelike game where players need to survive while encountering an evolving horde of monsters in a limited time. Eliminating monsters provides experience for players to level up which presents the player with several choices, such as upgrading their weapon, buying a new weapon or adding player buffs. Before the game starts, the player chooses their weapon and one of 3 difficulty modes: easy, middle, hard.
   
_Challenges:_
- How to create an evolving horde of monsters?
- How to design different weapons?
- How to balance the game difficulty and the fun of playing the game?
<br>

**2. Defend Zombies**

_Description:_
Players assume the role of a gardener using a variety of plants to protect their home from an ever-evolving zombie horde. During the day the player must prepare their home for assault by deploying plants, upgrading strategic defences, and using special props to defend against zombies. At night, waves of zombies descend on the player's house intending to cause havoc. As players progress, they can unlock more plant species and upgrades to face greater challenges.

_Challenges:_
- How to design unique zombies?
- How to design different defence towers?
- How to balance game difficulty and fun of playing the game?
<br>

**3. Grand Strategy Chess**

_Description:_
In Grand Strategy Chess, players will play the role of generals from different historical periods and command their armies to fight on a map composed of checkerboards. Each checkerboard represents a different terrain, such as plains, mountains, forests, and rivers, and each terrain will have an impact on the outcome of the battle. Players need to use strategic deployment, troop matching and terrain utilization to defeat their opponents and win.

_Core gameplay:_
Strategic deployment: Before battle, players need to deploy their own troops according to the opponent's arms and the map's terrain, and arrange infantry, cavalry, archer and special unit positions.
Combination of arms: Different arms have their own advantages and disadvantages on different terrains. Players must choose the most appropriate combination of arms based on the battlefield environment and the opponent's strategy.
Terrain utilization: Use the advantages of the terrain to deploy defense or attack.
Tactical change: Players can adjust tactics according to changes during battle, such as switching from defense to offense, or using special units to conduct surprise attacks.

_Challenges:_
- Balance: Ensuring all classes, special units, and terrain effects are balanced in the game, whether in single-player campaigns or multiplayer battles.
- Strategic Depth: Designing mechanics and tactical possibilities that are complex enough to satisfy players of all skill levels while keeping the game accessible.
- Map diversity: Create rich and diverse maps and campaign stories to increase the replay value of your game.
<br>

**4. Maze Tank Blitz**

_Description:_
In Maze Tank Blitz, players drive tanks to fight in a maze full of obstacles and traps. The goal of the game is to use your tank's cannon and special abilities to defeat your enemies while avoiding the maze's traps and enemy attacks. The game offers multiple different maze maps, each with unique designs and challenges. Players can fight alone or with friends in split-screen or online multiplayer modes.

_Core gameplay:_
Maze exploration: Players need to find the best path in a complex maze to attack enemies while avoiding being discovered and attacked by enemies.
Combat and Strategy: Players must take advantage of the maze's environment to defeat their opponents through strategic deployment and quick reactions.
Upgrades and Customization: After defeating enemies, players can collect resources to upgrade their tanks, including increased firepower, defense, and speed.

_Challenges:_
- Balance: Ensuring balance between all weapons to make the game both fair and challenging.
- Maze generation algorithm: Designing an algorithm to generate fair and interesting maze layouts and provide a diverse gaming experience.
- Special abilities: Implemeting a range of special items and distributing them fairly throughout the map.

<br>

---

## PART 3: REQUIREMENTS

### Stakeholder Identification

We identified the following stakeholders:

* Developers
* Project manager
* Players
* Project markers

<br>

### User Stories

>"As a developer, I want to make a game that is popular, so that I achieve more exposure and build a reputation."
>
>"As the project manager, I want to ensure the game developed is meets all requirements on time and on budget, so that financial stakeholders are satisfied."
>
>"As a player, I want to be able to select different levels of varying difficulties so that I can choose how intense my game will be based on my own experience."
>
>"As a player, I want to see how many lives my character has, so that I can adjust my in-game strategy and resource management to stay alive as long as possible."
>
>"As a player, I want to have be able to see tutorial examples so I can prepare a gameplay strategy."
>
>"As a marker for this project, I want to see groups create engaging and well made games, with a good twist and a strong development process that utilises the techniques taught in this module."

<br>

### Use-case specifications

_Easy Mode:_
Ghosts move randomly

_Hard Mode:_
Ghosts chase player

<br>

| Use-Case Section | Easy Mode | Hard Mode |
|-|-|-|
| **Description** | A run through of a level where ghosts' movement logic is random | A run through of a level where the ghosts' movement logic is determined by a pathfinding algorithm and ghosts will target the player |
| **Basic Flow**  | Consume all pellets in the level without dying | Consume all pellets in the level without dying |
| 1. | User places blocks on map to guide Pacman along a path of their choosing while avoiding collisions with ghosts | User places blocks on map to guide Pacman along a path of their choosing. Ghosts target Pacman, so user must devote more game resources to blocking the paths of incoming ghosts. |
| 2. | Pacman earns money by eating pellets, which the user can spend at the block shop to purchase more powerful blocks | User focuses on collecting pellets to purchase blocks which can slow or freeze ghosts' movements to more easily achieve the objective |
| 3. | User guides Pacman to consume all pellets on the map without being caught by a ghost | User guides Pacman to consume all pellets on the map without being caught by a ghost |
| **Alternative Flow** | Collision with ghost leads to Pacman losing a life and being respawned | Ghost chases and catches Pacman before user has time to block it's path or purchase a 'special' block |
| 1 | User guides Pacman around the map to collect pellets by placing blocks to block certain paths | User guides Pacman around map. Each new ghost released will use a pathfinding algorithm to dynamically target Pacman |
| 2 | User does not manage to place a block in time to stop Pacman from colliding with ghost or ghost makes an unexpected turn into Pacman's path | User navigates alternate waves of ghost attacks. Ghosts will periodically move towards the four corners of the map, and then will converge in on Pacman, finding the nearest alternative route if the user blocks their path. |
| 3 | Collision between Pacman and ghost reduces Pacman's lives by one and returns pacman to his spawn point. Repeat steps 1 and 2. | One or multiple ghosts converge in on Pacman and the user does not have enough blocks to prevent themselves being caught, resulting in the loss of a life and being respawned. Repeat steps 1 and 2. |
| 4 | If Pacman's lives are reduced to zero, the game ends. The user is prompted to input their name and their score is recorded. | If Pacman's lives are reduced to zero, the game ends. The user is prompted to input their name and their score is recorded. |

<br>

### Use-case diagram

To ensure the entire team was was on the same page regarding system-user interactions and the functional requirements of the game, we made use of several UML techniques. The use-case diagram was intended to act as a quick reference to show what our desired system behaviour is and how the different (planned) components should eventually interact with each other.  

<div align=center>
   <img src="asset/UseCaseDiagram.png"/>
</div>

<br>

### Class Diagram

The class diagram was initially created as a general blueprint for the game's structure which we would follow to maximise programming cohesion. As our ideas developed and the features we implemented increased, we gradually updated the class diagram and found it to be a useful visual aid throughout the development process, particularly as complexity grew. However, due to the speed of feature increments, the class diagram became a 'documentation' tool as opposed to a planning tool as we predominantly referred back to it during team meetings when presenting what changes we had made to the system. Although, it did aid in the development process as we were able to easily spot a few circular dsign malpractices and refactor them.

<div align=center>
   <img src="asset/ClassDiagram.png"/>
</div>

<br>

### Behavioural Diagram

As the complexity of the class diagram grew, it became increasingly difficult to decipher at a glance. We decided it would be beneficial to create a behavioural diagram to show the intended program flows.

<div align=center>
   <img src="asset/BehaviouralDiagram.png"/>
</div>

<br>

---

## PART 4: DESIGN

### System Architecture Overview

* Start Menu
   * START: start the main game.
   * LEVEL: choose the difficulty of the game, 5 levels in total, higher levels equates to higher difficulty and a higher score multiplier.
   * RANKING: show the 5 top scoring players in the ranking list.
   * HELP: show the functionality of the user interface in the main game.
   * EXIT：exit the game.
 
* Main Game
  * Player places blocks to stop ghosts from catching Pacman and ensuring Pacman consumes all pellets.

<div align=center>
   <img src="asset/Help.png"/>
</div>

* End Scene
   * YOU WIN: if all pellets are consumed, the player wins and is asked to enter their name and score.
   * GAME OVER: if Pacman's health is decreased to 0, the game is over and the player is asked to enter their name and score.

<br>

---

## PART 5: IMPLEMENTATION

### Challenges

**1. Pacman and ghosts's movement logic design & implementation:**

This proved to be the most challenging of our three challenges because of several reasons: 

First of all is the pacman's movement logic, in the early design stage, the pacman's movement logic is very complex in order to make it smart enough to eat all the dots, however, after we actually played the game, we found that it would be too easy for the player to win the game if we make the pacman so smart, so in the end we decide to make it not so smart so the player would need to use block to guide the pacman, in this way, the game is more interesting to play. 

Then, it was the ghosts' movement logic, which is also a ticky one, because there are four ghosts in our game, and each of them had a different movement logic according to the traditional pacman game, it took us quite some time to implement the four different movement logics to the ghosts. The main algorithm we used is called the A search algorithm, often pronounced as “A-star,” it is a powerful graph traversal and pathfinding technique. Let me break it down:

Objective:
Given a weighted graph, a source node, and a goal node, A* aims to find the shortest path (with respect to the given weights) from the source to the goal.

Key Features:
Completeness: A* guarantees that it will find a solution if one exists.
Optimality: It finds the optimal path (minimizing the total cost) among all possible paths.
Efficiency: A* efficiently explores the graph by using heuristics to guide its search.

Heuristics:
A* extends Dijkstra’s algorithm by incorporating heuristics.
It evaluates nodes based on a combination of two factors:
g(n): The actual cost from the start node to node n.
h(n): The estimated distance from node n to the goal node.
The evaluation function is f(n) = g(n) + h(n).

Trade-Off:
Unlike Dijkstra’s algorithm, which generates the entire shortest-path tree, A* focuses on finding the shortest path from the source to a specific goal.
This trade-off allows A* to use a goal-directed heuristic and achieve better performance.

Origins:
A* was invented by researchers working on the Shakey the Robot project in the late 1960s.
It builds upon the Graph Traverser algorithm, which used a heuristic function h(n).
Peter Hart introduced the concepts of admissibility and consistency of heuristic functions.

Space Complexity:
A* stores all generated nodes in memory, which can be a drawback in terms of space.
In practical travel-routing systems, other algorithms may outperform A* due to memory constraints.
Nevertheless, A* remains the best solution for many cases.

**2. Interaction between blocks and other things:**

This challenge may look like that it is not so difficult, but it was actually quite a challenge during the implementation. In our game design, there are four kinds of blocks which have different function: the basic block, the most fundamental block, has no function other than blocking the path; the slow block, other than its block path function, it can also slow the speed of the ghosts when it exist; the stop block, other than its block path function, it can also stop the ghosts when it exist; the transport block, it can not block the path but it can transport pacman to the select place. 

In our early design of our game, we didn't set a limit for the blocks, player can build as many as blocks as they want, but then we discover that it would be too easy for the player to win if there is no limit for building blocks, so we add a limit of three to the block building, if the player try to build a new block when there are already three blocks on the map, the earliest block will be destroied, but the transport block is a exception, it won't count for the limit since it can not block path.

During the test stage of the game, we found a mysterious bug: after we destroied the slow block or the stop block, the ghosts' movement logic broke sometimes, they will just moved straight out of the bound of the map, it was quite a strange bug since it wasn't happen all the time, sometimes it happened, sometimes it didn't, it took us quite some time to find out what trigger this bug: if we change the ghosts' speed after they leave the last grid and before they reach the next grid, its movement logic will broke, we then implemented a check function to make sure that their speed will only change after they reach the grid.


**3. How to balance different difficulties and the price of the blocks:**

This challenge might be the easiest challenge among these three challenges, but it did took us some time to balance the difficulties and the prices of the blocks. There are five levels of difficulty in our game, each level has a different map, at first, our thought was changed the speed of the ghosts to seperate different difficulties, but after we test it, we found out that the game would be very difficult even if we changed the speed just multiplied by two, so we decided to use another method to seperate the difficulties, since there are four ghosts in our game, we set a different release time according to the level that player chose, higher level means that all the four ghost will be released earlier, we seperate different release time by counting the dot pacman ate. As for the price of the blocks, the only problem is that the stop block is too powerful, the player can win easily with it, so we set the price of the stop block to a very high price to make sure that the player cannot put the stop block in the early stage of the main game.


# PART 6: EVALUATION

## Qualitative Evaluation

**Heuristic Evaluation**
* Project Title: Pacman Savior
![](asset/HeuristicEvaluation.png)
* Suggestions from players:
1. Add more interface/UI for the game to improve the HCI experience.
2. Add more instructions for the game to guide the players.
3. Add more difficulties to the game to add different experience.

## Quantitative Evaluation

### - GAME LEVEL 2 -

**NASA TLX**
| Player No | Mental demand | Physical demand | Temporal demand | Performance | Effort | Frustration | Raw score |
| ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- |
| 1 | 15 | 10 | 15 | 20 | 30 | 10 | 17 |
| 2 | 20 | 20 | 30 | 35 | 30 | 20 | 26 |
| 3 | 15 | 15 | 40 | 30 | 20 | 25 | 24 |
| 4 | 30 | 10 | 30 | 35 | 20 | 15 | 23 |
| 5 | 15 | 15 | 35 | 40 | 35 | 30 | 28 |
| 6 | 20 | 10 | 30 | 20 | 30 | 20 | 22 |
| 7 | 30 | 15 | 30 | 25 | 20 | 15 | 23 |
| 8 | 20 | 10 | 25 | 45 | 25 | 20 | 24 |
| 9 | 15 | 20 | 30 | 25 | 25 | 15 | 21 |
| 10 | 20 | 15 | 20 | 20 | 35 | 10 | 20 |

**System Usability Scale**
| Question No \ Player No | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 
| --------------- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | 
| 1. I think that I would like to use this system frequently. | 4 | 5 | 4 | 3 | 4 | 3 | 5 | 4 | 4 | 5 |
| 2. I found the system unnecessarily complex. | 2 | 1 | 2 | 3 | 2 | 1 | 2 | 1 | 3 | 2 |
| 3. I thought the system was easy to use. | 4 | 4 | 5 | 4 | 3 | 4 | 4 | 5 | 4 | 5 |
| 4. I think that I would need the support of a technical person to be able to use this system. | 1 | 1 | 2 | 2 | 1 | 1 | 2 | 1 | 1 | 2 |
| 5. I found the various functions in this system were well integrated. | 5 | 5 | 4 | 4 | 5 | 4 | 4 | 5 | 4 | 4 |
| 6. I thought there was too much inconsistency in this system. | 2 | 2 | 3 | 1 | 2 | 1 | 2 | 1 | 1 | 2 |
| 7. I would imagine that most people would learn to use this system very quickly. | 4 | 4 | 5 | 3 | 5 | 4 | 4 | 3 | 5 | 4 |
| 8. I found the system very cumbersome to use. | 2 | 3 | 2 | 2 | 1 | 2 | 1 | 2 | 2 | 1 |
| 9. I felt very confident using the system. | 5 | 5 | 4 | 4 | 4 | 4 | 5 | 5 | 4 | 5 |
| 10. I needed to learn a lot of things before I could get going with this system. | 1 | 1 | 2 | 2 | 3 | 2 | 2 | 2 | 1 | 1 |
| System Usability Survey Score | 85 | 87.5 | 77.5 | 70 | 80 | 80 | 82.5 | 90 | 82.5 | 87.5 |

### - GAME LEVEL 4 -

**NASA TLX**
| Player No | Mental demand | Physical demand | Temporal demand | Performance | Effort | Frustration | Raw score |
| ------- | ------- | ------- | ------- | ------- | ------- | ------- | ------- |
| 1 | 20 | 15 | 20 | 25 | 35 | 15 | 22 |
| 2 | 25 | 25 | 35 | 40 | 35 | 25 | 31 |
| 3 | 25 | 25 | 40 | 30 | 30 | 25 | 29 |
| 4 | 30 | 20 | 30 | 35 | 30 | 25 | 28 |
| 5 | 25 | 25 | 35 | 40 | 45 | 30 | 33 |
| 6 | 30 | 20 | 30 | 20 | 30 | 30 | 27 |
| 7 | 30 | 25 | 30 | 35 | 20 | 25 | 28 |
| 8 | 30 | 20 | 25 | 45 | 25 | 30 | 29 |
| 9 | 25 | 20 | 30 | 35 | 25 | 25 | 26 |
| 10 | 20 | 25 | 20 | 30 | 35 | 20 | 25 |

**System Usability Scale**
| Question No \ Player No | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 | 10 | 
| --------------- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | 
| 1. I think that I would like to use this system frequently. | 4 | 5 | 4 | 3 | 4 | 3 | 5 | 4 | 4 | 5 |
| 2. I found the system unnecessarily complex. | 2 | 1 | 2 | 3 | 2 | 1 | 2 | 1 | 3 | 2 |
| 3. I thought the system was easy to use. | 4 | 4 | 5 | 4 | 3 | 4 | 4 | 5 | 4 | 5 |
| 4. I think that I would need the support of a technical person to be able to use this system. | 1 | 1 | 2 | 2 | 1 | 1 | 2 | 1 | 1 | 2 |
| 5. I found the various functions in this system were well integrated. | 5 | 5 | 4 | 4 | 5 | 4 | 4 | 5 | 4 | 4 |
| 6. I thought there was too much inconsistency in this system. | 2 | 2 | 3 | 1 | 2 | 1 | 2 | 1 | 1 | 2 |
| 7. I would imagine that most people would learn to use this system very quickly. | 4 | 4 | 5 | 3 | 5 | 4 | 4 | 3 | 5 | 4 |
| 8. I found the system very cumbersome to use. | 2 | 3 | 2 | 2 | 1 | 2 | 1 | 2 | 2 | 1 |
| 9. I felt very confident using the system. | 5 | 5 | 4 | 4 | 4 | 4 | 5 | 5 | 4 | 5 |
| 10. I needed to learn a lot of things before I could get going with this system. | 1 | 1 | 2 | 2 | 3 | 2 | 2 | 2 | 1 | 1 |
| System Usability Survey Score | 85 | 87.5 | 77.5 | 70 | 80 | 80 | 82.5 | 90 | 82.5 | 87.5 |


# PART 7: PROCESS

In the early design stage of the game, we mainly used WhatsApp to discuss the ideas of our game online, and sometimes we had meetings at MVB to have a deeper discussion as well. This is the time when we gave different thoughts about what kind of game we wanted to develop, and how to add a good twist to it to make it more special. After considering the develop difficulties of all the ideas, we chose pacman savior in the end.

During the develop process of the game, we mainly use WhatsApp to keep in contact, Skype to have online meeting, and GitHub to keep a track of our changes. Normally, on the Monday of each week, we would have a online / offline meeting to discuss what should we do in this week, and divide different work that each of us should do carefully in order to prevent conflict when we push code to GitHub. When we meet a bug during the development, we would discuss the bug together by WhatsApp first if the bug is not so hard to solve, if we found out that it was a tricky one, we would discuss it by Skype so that we can share our screens to have a deeper communication about how to solve the bug.

* Here are our roles in this game project:

| Juean Chen                                | Xiaokang Fan                         | Nicky Dickson                        |
|-------------------------------------------|--------------------------------------|--------------------------------------|
| UI design & implementation                | Game framework construction          | Implemented pathfinder class to handle Ghost behaviour|
| Maps design & implementation              | Game engineering framework design    | Implemented Entity class to handle collisions|
| Block design & implementation             | Implement most page designs          | Extended Ghost and Pacman classes to inherit from Entity class|
| Original pacman movement logic design     | Implement the button class to simplify button implementation | Optimised Pacman movement behaviour and logic|
| Fix some bugs                             | Implement animation class            | Edited Report                        |
| Write most of the report                  | Optimize entity classes, extend movement methods and give physical meaning ||
| Add sound effect                          | Simplify ghost drawing logic         |                                      |
|                                           | Design game record manager class     |                                      |
|                                           | Fix some bugs                        |                                      |
|                                           | Algorithm optimization               |                                      |


# PART 8: CONCLUSION

First of all, we learned a lot during this game development process like the use and application of different development techniques and tools, and how to design and implement a project as a team. And we also gained more experience on how to solve a problem like a tricky bug by discussion in the team and teamwork, which will be very helpful when we go to work in the company. Besides, we also learned about how to schedule the work and divide the work to each member in the team evenly. Last but not the least, we have a wonderful and interesting teamwork experience in this game develop project, which will not only benefit our future development in the software engineering area, but also will be a fantastic memory in our lives.

If we had the time and resources to develop the game further the features we would want to add are: multiplayer mode, which will allow two people to play the game - one of them controls the pacman movement while the other place the block; infinite mode, which will have a map generator to produce infinite maps, the pacman will move to next map after it eats all the dots in the current map; reverse mode, in this mode, player's goal will change from keep pacman alive to help ghosts catch pacman, in this mode, the ai of the pacman will be very smart while the ai of the ghost will be not so smart.


# INDIVIDUAL CONTRIBUTION

* Juean Chen: 1.00
* Xiaokang Fan: 1.00
* Nicky Dickson: 1.00

