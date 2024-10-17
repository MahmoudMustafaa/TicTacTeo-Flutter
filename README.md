# Tic-Tac-Toe Game

This is a Flutter-based mobile application featuring a Tic-Tac-Toe game with different modes and additional features like a marketplace and challenges. The app is designed to provide both single-player and multiplayer experiences, offering a fun and competitive gaming environment.

## Features

- **Single Player Mode**: Play against the bot with an intelligent AI that automatically selects the best move.
- **Two Players Mode**: Compete with a friend in local multiplayer mode.
- **Trophy System**: Earn trophies when you win against the bot, with your progress saved using `SharedPreferences`.
- **Challenges**: Participate in special challenges to test your skills.
- **Marketplace**: Purchase in-game items and upgrades from the marketplace 
## Video Demonstration

[![Watch the video](https://img.youtube.com/vi/abcd1234/0.jpg)](https://youtu.be/EU65KJQefxw)


## Tech Stack

- **Dart**: The programming language used for building the application logic.
- **Flutter**: The UI framework for crafting the responsive user interface.
- **SharedPreferences**: Used to store and persist data such as player trophies locally on the device.

## Game Logic

- The game implements a basic Tic-Tac-Toe game with a 3x3 grid.
- In **Single Player Mode**, the bot uses a decision-making algorithm to find the best move to block or win the game.
- Players can reset the game at any time and view their score on a dynamically updated scoreboard.

## Widgets Used

- **GameButton**: A custom widget that represents each button in the Tic-Tac-Toe grid.
- **CustomDialog**: A dialog box that shows game results, whether it's a win, lose, or draw.

## How to Play

1. **Single Player Mode**: Start the game and play against the AI. Mark your position on the grid by tapping a cell, and the bot will make its move after yours.
2. **Two Players Mode**: Each player takes turns selecting a cell. The first to align three marks in a row (vertically, horizontally, or diagonally) wins.
3. Earn trophies as you win, which will be displayed in the app bar.

## Installation

1. Clone the repository:
   ```bash
   https://github.com/MahmoudMustafaa/TicTacTeo-Flutter.git
