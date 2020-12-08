import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smooth_pyramid/screens/home/components/data.dart';
import 'package:smooth_pyramid/screens/home/home.dart';

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 40.0;
  var verticalInset = 8.0;

  CardScrollWidget(
    this.currentPage,
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("yo ");
      },
      child: new AspectRatio(
        aspectRatio: widgetAspectRatio,
        child: LayoutBuilder(builder: (context, contraints) {
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = new List();

          for (var i = 0; i < images.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;

            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
              top: padding + verticalInset * max(-delta, 0.0),
              bottom: padding + verticalInset * max(-delta, 0.0),
              start: start,
              textDirection: TextDirection.rtl,
              child: Container(
                child: AspectRatio(
                    aspectRatio: cardAspectRatio,
                    child: Stack(
                      overflow: Overflow.clip,
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          images[i],
                          fit: BoxFit.contain,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Image.asset(
                            "assets/video/home6.gif",
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            fit: BoxFit.contain,
                          ),
                        )
                      ],
                    )),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        }),
      ),
    );
  }
}
