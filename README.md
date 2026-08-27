
# BO3-GSC-Mod-Library

A collection of custom GSC/CSC gameplay systems, scripting, and level design developed for Call of Duty: Black Ops III Zombies. This repository contains the source code and assets for *Nathan's Donuts and Ethan's Dungeon,* featuring event-driven gameplay, quest systems, interactive mechanics, dynamic lighting, environmental design and custom enemy behavior.

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

Quest progression is driven by player interactions and gameplay events rather than a linear script. Interactive entities wait for player-triggered events, update quest state, and invokes the appropriate progression logic.

![Nathan's Donuts Code Example 2](assets/code_example2.png) 

### Player Lockdown Event:

This lockdown sequence combines player interaction, multiplayer state validation, round-based progression, and environmental events. Before the lockdown beings, the system verifies that every active player is alive and within a defined radius of the activation trigger. once these requirements are met, the area is sealed and players must survive the required rounds, and the environment is updated when the lockdown begins and ends. 

![Nathan's Donuts Code Example 3](assets/code_example3.png) 

### Boss Encounter State Management

The final boss encounter is implemented as a multi-stage scripted system that coordinates player validation, enemy spawning, zone management, timed objectives, and stage transitions. Each stage has its own activation conditions and cleanup logic, allowing the encounter to progress through distinct gameplay phases.

![Nathan's Donuts Code Example 4A](assets/code_example4A.png) 

### Dynamic Enemy & Wave Scripting

Each phase of the boss fight takes place in a different room, with each phase introducing more enemies and boss zombies to progressively increase the difficulty. The encounter uses a scripted wave system to control enemy composition and pacing throughout the fight. Waves combine different enemy types, including high-health Panzers and Skullbreaker boss zombies. Each wave uses scripted delays and randomized spawn locations to create intense and unpredictable combat encounters. 

![Nathan's Donuts Code Example 4B](assets/code_example4B.png) 

### *Nathan's Donuts* Final Boss Gameplay
https://github.com/user-attachments/assets/27906294-3969-4f47-8fc7-24c935eae717

## Ethan's Dungeon — In Development

__Ethan's Dungeon__ is a larger-scale Call of Duty: Black Ops III Zombies project currently in development. Building on the scripting and level-design experience from *Nathan's Donuts,* the project expands into more complex gameplay systems, interactive mechanics, and significantly more detailed environmental design and visual representation. 

A major focus of the project is improving the map's graphical quality through more detailed environments, custom lighting probes, atmospheric effects, and clear visual themes. The project is still actively being developed, with additional gameplay systems and content planned for future implementation. 

### Ethan's Dungeon — Environmental & Visual Design

| Ethan's Dungeon: Main Chamber | Ethan's Dungeon: Cavern & Fog |
| :---: | :---: |
| ![Ethan's Dungeon Main Chamber](assets/Dungeon_chamber.png) | ![Ethan's Dungeon Cavern](assets/Dungeon_cave.png) |

### Ethan's Dungeon — Interactive Systems

One of the main goals of Ethan's Dungeon is to build upon the gameplay systems developed for Nathan's Donuts by creating more complex and interactive environmental mechanics.

### Interactive Jukebox System
The jukebox is organized into separate functions responsible for managing its interaction state, song selection, visual representation, and audio playback. The main function controls the jukebox's overall state, while a dedicated thread listens for song-change interactions until the jukebox is turned off.

![Ethan's Dungeon Code Example 1](assets/code_example5.png) 

https://github.com/user-attachments/assets/42266ece-28cc-4af0-9e5f-80de6917eebd

