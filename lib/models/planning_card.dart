// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum PlanningCard {
  ZERO,
  ONE,
  TWO,
  THREE,
  FIVE,
  EIGHT,
  THIRTEEN,
  TWENTY,
  FOURTY,
  HUNDRED,
  QUESTION,
}

extension PlanningCardExtension on PlanningCard {
  AssetImage get image {
    switch (this) {
      case PlanningCard.ZERO:
        return const AssetImage('images/cards/Card 0.png');
      case PlanningCard.ONE:
        return const AssetImage('images/cards/Card 1.png');
      case PlanningCard.TWO:
        return const AssetImage('images/cards/Card 2.png');
      case PlanningCard.THREE:
        return const AssetImage('images/cards/Card 3.png');
      case PlanningCard.FIVE:
        return const AssetImage('images/cards/Card 5.png');
      case PlanningCard.EIGHT:
        return const AssetImage('images/cards/Card 8.png');
      case PlanningCard.THIRTEEN:
        return const AssetImage('images/cards/Card 13.png');
      case PlanningCard.TWENTY:
        return const AssetImage('images/cards/Card 20.png');
      case PlanningCard.FOURTY:
        return const AssetImage('images/cards/Card 40.png');
      case PlanningCard.HUNDRED:
        return const AssetImage('images/cards/Card 100.png');
      case PlanningCard.QUESTION:
        return const AssetImage('images/cards/Card Question.png');
    }
  }

  String get title {
    switch (this) {
      case PlanningCard.ZERO:
        return '0';
      case PlanningCard.ONE:
        return '1';
      case PlanningCard.TWO:
        return '2';
      case PlanningCard.THREE:
        return '3';
      case PlanningCard.FIVE:
        return '5';
      case PlanningCard.EIGHT:
        return '8';
      case PlanningCard.THIRTEEN:
        return '13';
      case PlanningCard.TWENTY:
        return '20';
      case PlanningCard.FOURTY:
        return '40';
      case PlanningCard.HUNDRED:
        return '100';
      case PlanningCard.QUESTION:
        return '?';
    }
  }

  int get sortOrder {
    switch (this) {
      case PlanningCard.ZERO:
        return 0;
      case PlanningCard.ONE:
        return 1;
      case PlanningCard.TWO:
        return 2;
      case PlanningCard.THREE:
        return 3;
      case PlanningCard.FIVE:
        return 4;
      case PlanningCard.EIGHT:
        return 5;
      case PlanningCard.THIRTEEN:
        return 6;
      case PlanningCard.TWENTY:
        return 7;
      case PlanningCard.FOURTY:
        return 8;
      case PlanningCard.HUNDRED:
        return 9;
      case PlanningCard.QUESTION:
        return 10;
    }
  }
}
