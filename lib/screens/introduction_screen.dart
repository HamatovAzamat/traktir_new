import 'package:flutter/material.dart';

class IntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          flexibleSpace: FlexibleSpaceBar(
            background: Image.asset('assets/stamp.png'),
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
          ]),
        )
      ],
    );
  }
}
