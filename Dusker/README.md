Dusker single input engine-- i0002
by Aspore "https://github.com/Asporez"
based upon Yet Another Roguelike Tutorial by TStand90 "https://github.com/TStand90"

Short Synopsis: The year is 2085AD. Corporations colonized Mars and Main Belt. Earth is entirely dependent on those corporations, rich people flee Earth towards fully terraformed domed cities on Mars, life on Earth and in the extraction and refining facilities in orbit is miserable, life on Mars is luxurious. Oligarch uploads his consciousness to "Dusk Neuraloop" Experiment goes wrong on Mars with "Dusk Neuraloop" and connection to Earth is severed. UN on the brink of collapse as 82% of transactions around the world depend on neuraloop and Oligarch. Hacker anonymously provides a means to infiltrate neuraloop with a nanovirus called "Dusker", a simulated consciousness directly linked to a "volunteers" brain in order to escalate up Dusk's derelict databanks systems and find out what happened. Nobody has ever survived once the Dusker they are linked to has been annihilated.

Player=Dusker
Map=Derelict
NPCmob=Nanobot
    -mob0=Dybot
    -mob1=Modbot
    -mob2=Adminbot
    -mob4=Rootshell

"main.py":

"input_handlers.py":

"actions.py":

"entity.py":

"engine.py":

"game_map.dy":

"tile_types.py":

"procgen.py":
"import tcod" line 7 # might cause bug

"entity_factories.py"