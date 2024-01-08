import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class MyRatingBarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double initialRating = 0;

    return RatingBar.builder(
      initialRating: initialRating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 17,
      itemBuilder: (context, index) {
        return const Icon(
          Icons.star,
          color: Colors.amber,
        );
      },
      onRatingUpdate: (rating) {
        // 評価が更新されたときの処理
        print('Selected Rating: $rating');
      },
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Rating Bar Example'),
        ),
        body: Center(
          child: MyRatingBarWidget(),
        ),
      ),
    ),
  );
}
