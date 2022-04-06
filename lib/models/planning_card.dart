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
}
