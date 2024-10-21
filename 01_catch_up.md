# Catch Up

I'm a couple of weeks into the project and writing this on the third day of building the project in Godot. This post is to catch up during my day off before regularly writing dev logs at the end of each work day.

## What is this game?

This is a 2D top-down shooter for Android and web inspired by Zombies Ate My Neighbors! I'm also hoping to build a lot of functionality I can reuse for future 2D top-down shooters, as I am quite interested in the genre.

## Architecture

I'm trying hard to design this game for extensibility, modification, and reuse. I have some ambitious features in mind that drive some of this design (including online multiplayer and detailed record keeping).

The project uses Signals extensively. Pretty much everything that happens in the game is handled by emitting a Signal from an event bus so systems in the game can react to it.

This way, the information that's passed around can be listened to by any number of systems in the game and reused. I think integrating this with online multiplayer will make server authority and game state synchronization trivial.

It does make for some verbose Signals; all Signals related to Characters (players, enemies, and bosses) are technically listened to by all Characters in the game. Therefore, a unique ID is passed with every signal so listeners know if it's intended for them.

Unless it causes performance problems when the game has many Characters doing stuff, I will keep it this way. I don't think there's anything inherently wrong with it, though I would prefer to use ECS.

Another major architecture concern I wanted to bring up was the use of reusable Component scenes. Every Character in the game (and some other objects that aren't Characters) make use of Component Nodes that drive their behavior.

For example, PlayerCharacters need to track their inventory of weapons and items, switch between them, and use them. In the end, the Character itself uses these objects, but everything before that is a workflow of activities in the CharacterInventoryComponent triggered by input from the CharacterController.

All you have to do, generally, is instance Components on Characters and assign a reference to the parent Character in the Component's fields in the inspector. Each Component has one script, no extensions necessary, to drive every kind of Character's behavior.

What makes each character's behavior drastically different is their Controller. Controllers are Nodes that handle input (whether it be AI or player controls) and dispatch signals for the other Components and the Character to use to act.

Finally, the game uses Resources extensively. Every type of Character, Weapon, Item, and Pickup in the game gets its identity from Resource files on the disk. Because of the way the game is coded, it is trivially easy to add new weapons and items. Just make new Resources and Scenes (if applicable) and find the drop-down on the right object to test it.

It took a little setting up, but I think it will make for wonderfully flexible architecture. This way, implementing multiple playable characters (including enemies if it's called for) and syncing online multiplayer should be quite easy. It's also easy to drop in new input sources for different kinds of behavior.

## State of the game

Right now, you can walk around, pick up items and weapons, and cycle through your inventory. There is also code to be hit by Bullets and take damage, but it hasn't been tested yet. Next up I plan to implement the use of weapons and items, then make sure the life system works correctly.

I also plan to add the Survivors to the game in the next couple of days. Survivors are glorified pickups representing the people you rescue. They serve as level objectives and give players score. It will be extremely easy to set them up given the game's architecture.

A major technical concern that's occurred to me is localization. I want to learn how to make games easy to localize, so I did some research. I've landed on using XML documents to hold all the human-readable strings in the game. I'll write a script in F# to convert these XML files to text Resource files in the Godot project and add the data to an autoload script for easy drop-in anywhere a human-readable piece of text is needed.

I'll do something similar for UI elements, too. This is all inspired by Android Studio's Resource Manager and the ubiquity of XML for data-driven design (like in MonoGame).

Other than that, I'd like to tidy up all the code I have so far and make some dummy enemies to kill this week. Maybe I'll get basic multiplayer in too; that along with brain-dead AI for dummy enemies should help find holes in the Controller system.

After all of that, I'll consider the core of the Character systems functional. Big concerns in the weeks ahead include procedurally generating the levels in the game (after studying procedural generations a lot more and crafting a number of levels by hand) as well as implementing Android controls and testing the game on my phone.

There's a lot of work to do and I haven't even begun the hard parts, but that thought excites me. I relish the challenge. I've been reminded after about a year that working on games is the most rewarding thing in the world. I knew early on in my life that this was for me, even though I hadn't tried it yet. So don't forget anymore!

I think by the end of October I will have a very functional demo, albeit not too fun (as enemy AI and procedurally generated levels will likely not be in at all). After that I believe I can deliver my "spooky Halloween game" in mid-November. It is the indie way.