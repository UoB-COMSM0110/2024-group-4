import processing.sound.*;

SoundFile selectSound;
SoundFile clickSound;
SoundFile eatBigDotSound;
SoundFile eatSmallDotSound;
SoundFile gameOverSound;
SoundFile youWinSound;
//SoundFile placeBlockSound;
SoundFile startMenuSound;
SoundFile teleportSound;
SoundFile caughtSound;

// Initialise sounds effects and music
public void loadSounds() {
  selectSound = new SoundFile(this, "assets/button_select.mp3");
  clickSound = new SoundFile(this, "assets/button_click.mp3");
  eatBigDotSound = new SoundFile(this, "assets/eat_big_dot.mp3");
  eatSmallDotSound = new SoundFile(this, "assets/eat_small_dot.mp3");
  gameOverSound = new SoundFile(this, "assets/game_over.mp3");
  youWinSound = new SoundFile(this, "assets/you_win.mp3");
  //placeBlockSound = new SoundFile(this, "assets/place_block.mp3");
  startMenuSound = new SoundFile(this, "assets/start_menu.mp3");
  teleportSound = new SoundFile(this, "assets/PM_FN_Spawns_Portals_Teleports_29.mp3");
  caughtSound  = new SoundFile(this, "assets/ghost_catch_pacman.mp3");
}
