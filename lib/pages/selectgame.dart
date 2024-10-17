import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gaming/pages/challenges_page.dart';
import 'package:gaming/pages/single_player__page.dart';
import 'package:gaming/pages/market_page.dart';
import 'package:gaming/pages/two_players_page.dart';

class Selectgame extends StatelessWidget {
  const Selectgame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purple, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            Positioned(
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  "xoo.png",
                  width: double.infinity,
                  height: 500,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            child: Container(
                              width: 150,
                              height: 4,
                              color: Colors.yellowAccent,
                            ),
                          ),
                          const Text(
                            "Select Game",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 35,
                            ),
                          ),
                        ],
                      ),
                      Image.network("assets/removebg3.png"),
                    ],
                  ),
                  const SizedBox(height: 40),
                  GameOptionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SinglePlayerPage()));
                    },
                    imagePath: "assets/robot.png",
                    text: 'Single Player',
                    color: Colors.orange,
                  ),
                  const SizedBox(height: 15),
                  GameOptionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TwoPlayersPage()));
                    },
                    imagePath: "assets/play.png",
                    text: 'Two Players',
                    color: Colors.pink,
                  ),
                  const SizedBox(height: 15),
                  GameOptionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MarketPlacePage()));
                    },
                    imagePath: "assets/store.png",
                    text: 'Market Place',
                    color: Colors.purple,
                  ),
                  const SizedBox(height: 15),
                  GameOptionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChallengesPage()));
                    },
                    imagePath: "assets/Thrumpet.png",
                    text: 'Challenges',
                    color: Colors.blue,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Image.network("assets/ps4.png"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameOptionButton extends StatelessWidget {
  final String imagePath;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const GameOptionButton({
    super.key,
    required this.imagePath,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Image.network(
        imagePath,
        width: 40,
        height: 40,
      ),
      label: Text(
        text,
        style: const TextStyle(
            fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
