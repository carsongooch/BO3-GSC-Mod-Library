# BO3-GSC-Mod-Library

A collection of custom GSC/CSC gameplay systems, scripting, and level design developed for Call of Duty: Black Ops III Zombies. This repository contains the source code and assets for *Nathan's Donuts and Ethan's Dungeon,* featuring event-driven gameplay, quest systems, interactive mechanics, dynamic lighting, environmental design and custom enemy behavior.

## Level Design & Environmental Lighting

| Ethan's Dungeon: Main Chamber | Ethan's Dungeon: Cavern & Fog |
| :---: | :---: |
| ![Ethan's Dungeon Main Chamber](assets/Dungeon_chamber.png) | ![Ethan's Dungeon Cavern](assets/Dungeon_cave.png) |

### *Nathan's Donuts* — Project Impact
 ![Nathan's Donuts Player Stats](assets/n_stat.png) 

<div align="center">


| Metric |  Result |
|---|---:|
| Total Players |**6,463+** |
| Player Views |**20,079+** |
| Total Favorites |**258** |
| Positive Rating |**80%** |

</div>

## Nathan's Donuts Overview:
*Nathan's Donuts* is a fully playable custom Call of Duty: Black Ops III Zombies map developed using the Black Ops III Mod Tools. I designed and implemented the map's gameplay systems, scripted interactive quests and mechanics, along with custom enemy behavior using GSC.

The quest is structured as a sequence of interconnected objectives, with branching gameplay tasks resulting in a final boss encounter.

![Nathan's Donuts Quest Overview](assets/Nathan_Diagram.png) 

## Nathan's Donuts — Code Implementations

### Multi-Stage Quest Architecture:

Nathan's Donuts Main Quest is structured as a sequence of interconnected stages, with each stage responsible for a specific objective and progression state. Shared level variables track important conditions, allowing individual systems to determine when their requirements have been met and when the next stage of the quest can be activated.

![Nathan's Donuts Code Example 1](assets/code_example1.png) 

## Event-Driven Gameplay:

Quest progression is driven by player interactions and gameplay events rather than a linear script. Interactive entities wait for player-triggered events, update quest state, and invokes the apporpriate progression logic.

![Nathan's Donuts Code Example 1](assets/code_example2.png) 

### Code Example Three:



### *Nathan's Donuts* Final Boss Gameplay
https://github.com/user-attachments/assets/27906294-3969-4f47-8fc7-24c935eae717


