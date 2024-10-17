import 'package:flutter/material.dart';
import 'package:gaming/widgets/custom_Appbar.dart';
import 'package:gaming/widgets/custom_dailog.dart';
import 'package:gaming/widgets/game_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TwoPlayersPage extends StatefulWidget {
  const TwoPlayersPage({super.key});

  @override
  _TwoPlayersPageState createState() => _TwoPlayersPageState();
}

class _TwoPlayersPageState extends State<TwoPlayersPage> {
  late List<GameButton> buttonsList;
  var player1;
  var player2;
  var activePlayer;
  int player1Score = 0;
  int player2Score = 0;
  int trophies = 0;

  @override
  void initState() {
    super.initState();
    _loadTrophies();
    buttonsList = doInit();
  }

  _loadTrophies() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      trophies = prefs.getInt('trophies') ?? 0;
    });
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
                playSoundCondition: false),
          );
        }
      }
    });
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
        showDialog(
          context: context,
          builder: (_) => CustomDialog("Player 1 Won",
              Image.asset("trophy.png"), resetGame, 'bravo.mp3'),
        );
      } else {
        player2Score++;
        showDialog(
          context: context,
          builder: (_) => CustomDialog("Player 2 Won",
              Image.asset("trophy.png"), resetGame, 'bravo.mp3'),
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
      appBar: CustomAppBar(
        trophies: trophies,
        titleText: 'Two Player',
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            "spiderman.jpg",
            fit: BoxFit.cover,
          )),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildScoreBoard(
                        "Player 1", player1Score, Colors.pinkAccent),
                    _buildScoreBoard("Player 2", player2Score, Colors.green),
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
