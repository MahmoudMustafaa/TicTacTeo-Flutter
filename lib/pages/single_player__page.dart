import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gaming/widgets/custom_dailog.dart';
import 'package:gaming/widgets/game_button.dart';

class SinglePlayerPage extends StatefulWidget {
  const SinglePlayerPage({super.key});

  @override
  _SinglePlayerPageState createState() => _SinglePlayerPageState();
}

class _SinglePlayerPageState extends State<SinglePlayerPage> {
  late List<GameButton> buttonsList;
  late List<int> player1;
  late List<int> player2;
  var activePlayer;
  int player1Score = 0;
  int player2Score = 0;
  int trophies = 0;

  @override
  void initState() {
    super.initState();
    buttonsList = doInit();
    _loadTrophies();
  }

  _loadTrophies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      trophies = prefs.getInt('trophies') ?? 0;
    });
  }

  _saveTrophies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('trophies', trophies);
  }

  List<GameButton> doInit() {
    player1 = <int>[];
    player2 = <int>[];
    activePlayer = 1;

    var gameButtons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];

    return gameButtons;
  }

  void playGame(GameButton gb) {
    setState(() {
      if (activePlayer == 1) {
        gb.text = "O";
        gb.bg = Colors.pinkAccent;
        activePlayer = 2;
        player1.add(gb.id);
      } else {
        gb.text = "X";
        gb.bg = Colors.green;
        activePlayer = 1;
        player2.add(gb.id);
      }
      gb.enabled = false;

      int winner = checkWinner();
      if (winner == -1) {
        if (buttonsList.every((p) => p.text != "")) {
          showDialog(
              context: context,
              builder: (_) => CustomDialog(
                  "Draw", Image.asset("draw.png"), resetGame, 'bravo.mp3',
                  playSoundCondition: false));
        } else {
          if (activePlayer == 2) {
            autoPlay();
          }
        }
      }
    });
  }

  void autoPlay() {
    var cellID = findBestMove(player2, player1);

    if (cellID == -1) {
      cellID = findBestMove(player1, player2);
    }

    if (cellID == -1) {
      var emptyCells = <int>[];
      for (var i = 1; i <= 9; i++) {
        if (!player1.contains(i) && !player2.contains(i)) {
          emptyCells.add(i);
        }
      }
      var rand = Random();
      cellID = emptyCells[rand.nextInt(emptyCells.length)];
    }

    int i = buttonsList.indexWhere((p) => p.id == cellID);
    playGame(buttonsList[i]);
  }

  int findBestMove(List<int> currentPlayer, List<int> opponent) {
    List<List<int>> winningCombinations = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ];

    for (var combination in winningCombinations) {
      var countPlayer = 0;
      var emptyCell = -1;

      for (var cell in combination) {
        if (currentPlayer.contains(cell)) {
          countPlayer++;
        } else if (!opponent.contains(cell)) {
          emptyCell = cell;
        }
      }

      if (countPlayer == 2 && emptyCell != -1) {
        return emptyCell;
      }
    }

    return -1;
  }

  int checkWinner() {
    var winner = -1;

    if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(2) &&
        player2.contains(3)) {
      winner = 2;
    }

    if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
      winner = 1;
    } else if (player2.contains(4) &&
        player2.contains(5) &&
        player2.contains(6)) {
      winner = 2;
    }

    if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(7) &&
        player2.contains(8) &&
        player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(4) &&
        player2.contains(7)) {
      winner = 2;
    }

    if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
      winner = 1;
    } else if (player2.contains(2) &&
        player2.contains(5) &&
        player2.contains(8)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(3) &&
        player2.contains(6) &&
        player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
      winner = 1;
    } else if (player2.contains(1) &&
        player2.contains(5) &&
        player2.contains(9)) {
      winner = 2;
    }

    if (player1.contains(3) && player1.contains(5) && player1.contains(7)) {
      winner = 1;
    } else if (player2.contains(3) &&
        player2.contains(5) &&
        player2.contains(7)) {
      winner = 2;
    }

    if (winner != -1) {
      if (winner == 1) {
        player1Score++;
        trophies++;
        _saveTrophies();
        showDialog(
            context: context,
            builder: (_) => CustomDialog(
                "You Win", Image.asset("trophy.png"), resetGame, 'bravo.mp3'));
      } else {
        player2Score++;
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
              "You Lose!", Image.asset("sad.png"), resetGame, 'lose.mp3',
              playSoundCondition: false),
        );
      }
    }

    return winner;
  }

  void resetGame() {
    setState(() {
      buttonsList = doInit();
      player1 = [];
      player2 = [];
      activePlayer = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Single Player',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Text(
            '$trophies',
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          IconButton(
            icon: const Icon(Icons.emoji_events, color: Colors.yellow),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.network(
            "assets/spiderman.jpg",
            fit: BoxFit.cover,
          )),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildScoreBoard("You", player1Score, Colors.pinkAccent),
                    _buildScoreBoard("Bot", player2Score, Colors.green),
                  ],
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: buttonsList.length,
                  itemBuilder: (context, i) => Container(
                    decoration: buttonsList[i].decoration,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12.0),
                        onTap: buttonsList[i].enabled
                            ? () => playGame(buttonsList[i])
                            : null,
                        child: Center(
                          child: Text(
                            buttonsList[i].text,
                            style: buttonsList[i].textStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: resetGame,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(
                      color: Colors.yellowAccent,
                      width: 2.0,
                    ),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50.0,
                    vertical: 20.0,
                  ),
                  shadowColor: Colors.transparent,
                ),
                child: const Text(
                  "Reset Game",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildScoreBoard(String player, int score, Color color) {
    return Column(
      children: [
        Text(
          player,
          style: TextStyle(
              color: color, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          "$score",
          style: const TextStyle(color: Colors.white, fontSize: 24),
        ),
      ],
    );
  }
}
