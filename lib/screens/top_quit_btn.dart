import 'package:flutter/material.dart';
import 'package:smooth_pyramid/intermediaire/inter.dart';

class TopQuitButton extends StatelessWidget {
  const TopQuitButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(
        top: 50.0,
      ),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Inter(),
            ),
          );
        },
        child: Icon(
          Icons.logout,
          color: Colors.white,
          size: 40.0,
        ),
      ),
    );
  }
}
