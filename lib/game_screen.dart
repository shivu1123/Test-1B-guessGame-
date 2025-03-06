import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_state.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final game = Provider.of<HangmanState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Hangman Game"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[200]!, Colors.deepPurple[900]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Wrong guesses counter with custom style
              Text(
                "Wrong Guesses: ${game.wrongGuesses}/6",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
              ),
              SizedBox(height: 20),

              // Word display with a cool font and underline effect
              Text(
                game.displayWord,
                style: TextStyle(
                  fontSize: 50,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'RobotoMono',
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationStyle: TextDecorationStyle.dotted,
                ),
              ),
              SizedBox(height: 20),

              // Letter buttons with some hover effects and padding
              Wrap(
                spacing: 10,
                alignment: WrapAlignment.center,
                children: 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('').map((letter) {
                  return ElevatedButton(
                    onPressed: game.isGameOver
                        ? null
                        : () => game.guessLetter(letter),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: Colors.purpleAccent, // Changed from 'primary'
                    ),
                    child: Text(
                      letter,
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 30),

              // Game Over message with different colors for win and loss
              if (game.isGameOver)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: game.isWordGuessed ? Colors.green[300] : Colors.red[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        game.isWordGuessed ? "🎉 You Won!" : "💀 You Lost! Word was: ${game.currentWord}",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => game.resetGame(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent, // Changed from 'primary'
                        ),
                        child: Text(
                          "Play Again",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
