import 'package:business/widget/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

final defaultInitialReaction = Reaction(
  id: 99,
  title: _buildTitle('Like'),
  previewIcon:
      _buildReactionsPreviewIcon('assets/images/reacts/like_border.png'),
  icon: _buildReactionsIcon(
    'assets/images/reacts/like_border.png',
    'لايك',
  ),
);

final reactions = [
  Reaction(
    id: 2,
    title: _buildTitle('Sad'),
    previewIcon: _buildReactionsPreviewIcon('assets/images/reacts/sad.png'),
    icon: _buildReactionsIcon(
      'assets/images/reacts/sad.png',
      'احزنني',
    ),
  ),
  Reaction(
    title: _buildTitle('Like'),
    previewIcon: _buildReactionsPreviewIcon('assets/images/reacts/like.png'),
    icon: _buildReactionsIcon(
      'assets/images/reacts/like.png',
      'لايك',
    ),
  ),
  Reaction(
    title: _buildTitle('Love'),
    previewIcon: _buildReactionsPreviewIcon('assets/images/reacts/love.png'),
    icon: _buildReactionsIcon(
      'assets/images/reacts/love.png',
      'احببته',
    ),
  ),
  Reaction(
    title: _buildTitle('Wow'),
    previewIcon: _buildReactionsPreviewIcon('assets/images/reacts/wow.png'),
    icon: _buildReactionsIcon('assets/images/reacts/wow.png', 'واااو'),
  ),
  Reaction(
    title: _buildTitle('Angry'),
    previewIcon: _buildReactionsPreviewIcon('assets/images/reacts/angry.png'),
    icon: _buildReactionsIcon('assets/images/reacts/angry.png', 'اغضبني'),
  ),
];

Widget _buildTitle(String title) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 7.5, vertical: 2.5),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

Widget _buildReactionsPreviewIcon(String path) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.5, vertical: 5),
      child: Image.asset(path, height: 40),
    );

Widget _buildReactionsIcon(String path, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 12.0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(path, height: 20),
        const SizedBox(width: 4.0),
        CustomText(
          alignment: Alignment.center,
          text: text,
          fontSize: 12,
          color: Colors.grey,
        ),
      ],
    ),
  );
}
