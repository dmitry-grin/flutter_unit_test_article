import 'package:unit_test_article/replicant/replicant.dart';
import 'package:unit_test_article/survey.dart';

import 'replicant/replicant_interfaces.dart';

void main() {
  final human = Human(mathAbility: SimpleMath(), emotions: Emotions());
  human.mathAbility.compute(MathOperator.ADDITION, 24, 674);

  final replicant = Replicant();
  replicant.askMathQuestion(MathOperator.DIVISION, 831, 23);
}

class Human implements Survey {
  final SimpleMath mathAbility;
  final Emotions emotions;

  Human({this.mathAbility, this.emotions});

  @override
  Future<num> askMathQuestion(MathOperator action, int a, int b) async {
    final int aDigits = a.toString().length;
    final int bDigits = b.toString().length;
    if (aDigits >= 3 && bDigits >= 3) {
      emotions.puzzled();
    }
    return mathAbility.compute(action, a, b);
  }

  @override
  Future<Answer> askGeneralQuestion(GeneralQuestion question) {
    throw UnimplementedError();
  }
}

class Emotions {
  puzzled() {
    print('puzzled');
  }
}
