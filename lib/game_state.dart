import 'package:flutter/material.dart';

class HangmanState extends ChangeNotifier {
  // List of words to choose from for the game
  final List<String> words = ["FLUTTER", "STATE", "WIDGET", "HANGMAN"];
  late String currentWord; // Holds the current word to guess
  Set<String> guessedLetters = {};
  int wrongGuesses = 0; // Track the number of wrong guesses

  static const int maxGuesses = 6; // Maximum number of wrong guesses allowed

  // Constructor: Selects a random word when the game starts
  HangmanState() {
    _selectRandomWord(); // Calls the method to select a random word
  }

  // Selects a random word from the list and resets the game state
  void _selectRandomWord() {
    currentWord = (words..shuffle()).first; // Shuffles and selects the first word from the list
    guessedLetters.clear();
    wrongGuesses = 0;
    notifyListeners(); // Notifies listeners (widgets) to rebuild with the updated state
  }

  // Returns the word with blanks for unguessed letters and actual letters for guessed ones
  String get displayWord {
    return currentWord.split('').map((letter) {
      // Checks if the guessed letters contain the current letter
      if (guessedLetters.contains(letter)) {
        return letter; // Reveals the letter if guessed correctly
      } else {
        return '_';
      }
    }).join(' '); // Joins the letters/underscores with a space
  }

  // Handles the guess for a letter
  void guessLetter(String letter) {
    // If the letter has already been guessed, do nothing
    if (guessedLetters.contains(letter)) return;

    guessedLetters.add(letter); // Adds the letter to the guessed letters set
    // If the letter is not in the current word, increment the wrong guesses
    if (!currentWord.contains(letter)) {
      wrongGuesses++;
    }
    notifyListeners();
  }

  // Determines if the game is over (when the max wrong guesses are reached or the word is fully guessed)
  bool get isGameOver => wrongGuesses >= maxGuesses || isWordGuessed;

  // Checks if the word has been completely guessed (i.e., all letters are in the guessed set)
  bool get isWordGuessed => currentWord.split('').every((letter) => guessedLetters.contains(letter));

  // Resets the game by selecting a new word
  void resetGame() {
    _selectRandomWord();
  }
}
