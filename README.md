# notes (for my sanity)

just stuff i need to keep track of. if people actually are intrested in this garbage of mine, then i'll make an actual readme.

## script responsibilities

handler
- player loadout
- loading maps
- keeping player data
- kindly asking the map_handler to do things
- networking and lobbies (maybe)

map_handler
- spawning the player
- keeping track of player status
	- dead/alive [not directly. the player keeps track of their health and tells the map_handler when they die or come back alive somehow.]
	- special objectives/modifiers (ex. is player marked for death?)
	- maybe more
	- player team affiliation (this is so if maps can have special teams, or no teams at all.)
- keeping track of game status 
	- timer
	- win condition (ex. give a point to purp team if they own all the control points)
	- scoreboard
	- maybe more

this seperation of responsibilities exists not only to keep my spaghetti code in check, but also to give more control to map makers.

## map structure

- maptype_mapname (Node)
	- map_handler (Node) **[every map must have this]**
	- WorldEnviornment (WorldEnviornment) [everything is in contained in here]
		- spawns (Node) [in the case of game modes without teams, spawns can be put directly in this node instead of one node down]
			- orange_spawns (Node)
				- spawn0 (Marker3D)
				- ...etc [more spawns]
			- purple_spawns (Node)
				- spawn0 (Marker3D)
				- ...etc [more spawns]
		- main (Node)
			- static [anything that doesn't move]
				- staticpartnamehere (StaticBody3D)
				- ...etc [trust me, there's gonna be a lot.]
			- dynamic [anything that moves/changes; ex. props, doors, etc.]
				- dynamicpartnamehere (RigidBody3D)
	  			- ...etc
			- light
				- sun (DirectionalLight3D)
				- ...etc [more lights]
			- ...whatever else a mapper may need

## what happens upon a map being loaded:

1. handler checks if the map exists
2. handler checks if the map handler exists
3. map handler checks if spawn exists
4. map handler spawns player at their team spawn, using data from the handler
5. player requests weapons from the handler
6. player has fun (debateable)

## map types:

- s& - sandbox - there are no rules!
- ffa - free for all - a mode that only exists so i can put off adding teams lol
