/// All possible states the virtual pet can be in.
/// Maps 1-to-1 with the old GIF filenames for easy migration.
enum PetState {
  idle,      // Entry.gif  — default calm state
  happy,     // Happy.gif
  sad,       // Sad.gif
  anxious,   // Anxious.gif
  calm,      // Calm.gif
  okay,      // Okay.gif
  listen,    // Listen.gif — mic tapped
  gift,      // Gift.gif   — gift/treat received
  pet,       // Pet.gif    — user pets the cat
  feed,      // Feed.gif
  hungry,    // Hungry.gif
}
