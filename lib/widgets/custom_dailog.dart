import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget image;
  final VoidCallback callback;
  final String actionText;
  final String sound;
  final bool playSoundCondition;
  final AudioPlayer _player = AudioPlayer();

  CustomDialog(this.title, this.image, this.callback, this.sound,
      {this.actionText = "Reset", this.playSoundCondition = true});

  @override
  Widget build(BuildContext context) {
    playSound() {
      if (playSoundCondition) {
        _player.play(AssetSource(sound));
      }
    }

    WidgetsBinding.instance.addPostFrameCallback((_) => playSound());
    return AlertDialog(
      backgroundColor: Colors.grey,
      title: Center(
        child: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      content: SizedBox(
        width: 200,
        height: 150,
        child: image,
      ),
      actions: <Widget>[
        Center(
          child: TextButton(
            onPressed: () {
              _player.stop();
              Navigator.pop(context);
              callback();
            },
            style: TextButton.styleFrom(
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
                fontWeight: FontWeight.bold,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 50.0,
                vertical: 20.0,
              ),
              shadowColor: Colors.transparent,
            ),
            child: Text(
              actionText,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
