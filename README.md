# Competitive FTC Base: LUA scripts
Comp FTC Map Base LUA Scripts v2.42

The following files contain all the LUA scripts contained in the Competitive FTC Base Map for the TTS 40k community. If a file does not exist for an object within the TTS save, then that object does not contain any scripts.

This repo now contains the actual TTS JSON file. To produce the JSON file, run the compile.ps1 script.

Credit and thanks to GenWilhelm, BaconCatBug, Phubar, Mothman_Zack, Zyllos and Kurcenkurce for their hard work developing/maintaining earlier versions of this mod, and elements contained within it!

## Update History:

### v2.43

* Major performance enhancement: mission pack data is no longer included in save files, eliminating the regular slowdown seen when the scoresheet was in use.
* Minor performance enhancement: mission pack data is now downloaded once and shared between the scoreboard and secondary objective managers, speeding up load time and use of those features.
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
