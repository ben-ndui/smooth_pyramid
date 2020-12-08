import 'package:flutter/material.dart';

class HomeBackground extends StatelessWidget {
  final String homeBackURL;
  const HomeBackground({
    Key key,
    @required this.homeBackURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        homeBackURL,
        fit: BoxFit.cover,
      ),
    );
  }
}
