# Competitive FTC Base: LUA scripts
Comp FTC Map Base LUA Scripts v2.65

The following files contain all the LUA scripts contained in the Competitive FTC Base Map for the TTS 40k community. If a file does not exist for an object within the TTS save, then that object does not contain any scripts.

This repo now contains the actual TTS JSON file. To produce the JSON file, run the compile.ps1 script.

Credit and thanks to GenWilhelm, BaconCatBug, Phubar, Mothman_Zack, Zyllos and Kurcenkurce for their hard work developing/maintaining earlier versions of this mod, and to Trashpanda, Rob Mayer, Gizmo, MoonkeyMod, Liyarin, Josie, FChippendale, Tyrone and MariusEvander for contributions to it / elements contained within it!

## Update History:

### v2.65

* Chapter Approved 2025 is here - and with it, we bid a fond farewell to Leviathan / Pariah Nexus, now removed from the code.
* Restore "action in progress" markers
* Show/hide zone buttons updated to the set needed for CA25

### v2.64

* Minor bugfix - handled missing objective cylinder collider.

### v2.63

* Updated the PDFs to the updated WarCom URLs. Sorry for the delay, and thanks to powens for the PR.
* Updated the Linchpin and Storm Hostile Objective cards in line with the Pariah Nexus errata.
* Removed some accidentally-left-in debugging prints!

### v2.62

* Fixed the dice roller reporting the fifth-last roll instead of the last roll. (For good measure, also changed the last 5 rolls to number them 5-4-3-2-1 instead of 1-2-3-4-5!)

### v2.61

* Updated the Pariah Nexus cards with the day 1 errata.
* Added GW's recommended Pariah Nexus mission combos.
* Replaced Leviathan reference sheet with Pariah Nexus. (I figure there shouldn't be anyone left playing Leviathan for the first time!)
* Renamed "Show Engage" button to "Show Leviathan Engage" - use Show Table Quarters for Pariah Nexus Engage!
* Added a "Show Containment" button giving you 9" from board edges.
* Fixed the bug whereby a player who joined/chose colour after the mission pack was selected wouldn't get fixed secondary cards.

### v2.60

* Support for Pariah Nexus!
* The controls to raise/lower deployment zones and objectives now persist after the game has started.

### v2.59

* The secondaries deck is now shuffled when you draw from it.
* Tablet has been removed. Hopefully y'all have figured out the card system by now.
* Faction datasheets bag has been removed, since it was only ever intended as a stopgap prior to Yellowscribe 10e support and was getting outdated.

### v2.58

* Added alternative deployment zone/objective layouts for when Hidden Supplies is in use.
* Automatically reveal secondaries once both players have locked them in.
* Added a tablet showing how to use the mission cards.
* Fixed a bug with player promotion (thanks to snowTH for the PR).
* Updated keyword reference sheet with new Dev Wounds rule.

### v2.57

* Moved the show/hide DZs button to avoid clash with Signals.

### v2.56

* Added a button to show/hide Investigate Signals zones.

### v2.55

* Added a manual selector for GW-approved tournament mission combos.
* Replaced Purge the Foe primary card with a corrected version.
* Fixed the tooltip on Emergency Evacuation gambit card.

### v2.54

* Replaced Priority Targets primary card with a corrected version.

### v2.53

* Combat Patrol support added, courtesy of Keslor.

### v2.52

* Fixed the broken chess clock.
* Fixed the duplicated primary card.

### v2.51

* Improved the card graphics, with thanks to Tyrone.
* Updated primary/secondary cards with GW's changes to servo skulls / homers / BEL.
* Further token improvements: some replacement graphics, added AP mods.
* Added a second random mission button that only uses GW's recommended tournament combos.
* Added Leviathan mission reference card.
* Added instructions for using cards - written and video.
* Added bag of datasheets.

### v2.50

Yes, I skipped a version to start 10th edition on a nice round number. Sue me.

**Tenth edition support!**
* Scoresheet reworked to suit 10e missions.
* Decks of 10e mission cards added.
* Hands reinstated to support playing with cards.
* Secondary objective manager replaced with buttons to lock in secondaries and work with gambits.
* Deployment zones/objectives merged together and replaced with Leviathan ones.
* Tokens slightly updated for 10e. (More changes to come later on this front.)
* Core stratagem and keyword reminder sheets added.

### v2.48

* New terrain mirroring option for map making. Place the terrain for one half of the board and lock it in place, then press the new Mirror Terrain button, and each piece will be duplicated, rotated 180 degrees and placed in the mirrored position on the other half of the board.

### v2.47

* Dice table improvements: use the rotation values built into dice objects instead of calculating them manually, and spawn dice at the correct rotation instead of spawning them and then rotating them (fix supplied by FChippendale - many thanks!)
* Further token improvements - updated more tokens to match new set, and added +1/-1 attack/strength/toughness.

### v2.46

* Added a button for each player to gain a CP. This button remembers whether you've gained a CP this battle round and won't let you gain a second.
* When you show lines for Strategic Reserves, the lines corresponding to player battlefield edges will now show in that player's colour.
* New button to show For the Dark Gods zones (middle of table quarters).
* Objective markers now have states 4 and 5 to colour them in player colours, if you prefer that as a mechanic for recording sticky control (or even just who has _current_ control).
* Swapped the deployment zones on some maps so that red's always on the left and blue on the right!

### v2.45

* Support for ordered dice rolling, in order to facilitate effects like extra damage on 6s to wound into multi-wound models.
* Also supports grouping, useful for feel-no-pains from multi-damage attacks into multi-wound models.
* New button to show lines for Strategic Reserves arriving.

### v2.44

* New button to show lines for Engage on All Fronts / Retrieve Battlefield Data.

### v2.43

* Secondary objective selection overhauled, offering a drop-down or typing interface in place of clicking through a long list.
* Reference the 9e-combined pack repo, which brings generic and faction secondaries together into combined packs.
* Arks of Omen support added. Once better-quality scans are available, please report any issues you find!
* The set of status tokens has been revamped, and now reflects a much more 9th-edition-appropriate set, with options like "obsec" or "fight last" added and options like "+3 to hit" moved to a legacy bag. Huge thanks to Trashpanda for the new token graphics set.
* Status tokens, banners and sticky objective markers are now infinite bags - just drag away to create one.
* Major performance enhancement: switched to a better JSON library, eliminating the multi-second delay every time you load a save.
* Major performance enhancement: mission pack data is no longer included in save files, eliminating the regular slowdown seen when the scoresheet was in use.
* Minor performance enhancement: mission pack data is now downloaded once and shared between the scoreboard and secondary objective managers, speeding up load time and use of those features.
* Dice roller/mat enhancements:
    * The buttons to select all dice, or select dice with particular values, have been replaced with buttons that immediately roll those dice. For example, you can re-roll 1s by clicking the button that used to select your 1s, or re-roll all 1s/2s/3s by right-clicking Roll 3. If you want the old behaviour back, just right-click "Roll all dice" to toggle between rolling and selecting.
    * Custom dice are now supported. Clear the mat, place a single die on it, then click "Custom Dice". Spawned dice will now be copies of that original one.
    * The text in the bottom-left of the dice mat now shows you both how many dice are on the mat and what they sum to.
    * You can move the roller and mat separately. Dice will spawn aligned with the mat wherever it is.
    * Printouts of recent rolls are a bit more readable.
* Show/hide table quarters and area denial buttons now available during deployment as well as mid-game.
* Mission-specific scoring no longer capped at 15 - now you can record those ludicrous Conversion scores!
* More visible and stable banner models.

### v2.42

* Dice roller tweaked to (customisably) no longer rotate dice after spawning them, in the hopes of fixing physics issues encountered by some players.

### v2.41

* War Zone Nephilim now supported. Ensure the score card is set to GT: Nephilim or Nephilim Factions, and both players will get a CP each turn.

### v2.40

* Some Incursion missions were missing their center objective, now added.

### v2.39

* Nachmund Incursion missions added.
* Fixed broken objective marker scaling (broken in v2.38).
* Objectives are now spawned from a single, hidden template; markers 1-6 are now standalone and never cloned. The template has the "objective" tag built into its alternate states so that spawned objectives correctly despawn/change height even after having their state changed.

### v2.38

* Mat-style state is now the default for objectives.
* Fixed the orientation of the red reserves mat.

### v2.37

* Added chess clock, reserves boards, dice cams, banners and objective control markers, mission dice, action tokens.
* Objectives now have a mat-style state.

### v2.36

* Nachmund Strike Force missions added.

### v2.35

* Hard forked from https://github.com/Zyllos/tts_ftc_base_lua_scripts
* Score sheet updated to support (only) GT22
