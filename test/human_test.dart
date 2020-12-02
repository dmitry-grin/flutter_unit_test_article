import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_test_article/survey.dart';
import 'package:unit_test_article/main.dart';

class EmotionsMock extends Mock implements Emotions {}
class HumanMathMock extends Mock implements SimpleMath {}

main() {
  Human human;
  EmotionsMock emotionsMock;
  HumanMathMock humanMathMock;

  setUp(() {
    emotionsMock = EmotionsMock();
    humanMathMock = HumanMathMock();

    human = Human(emotions: emotionsMock, mathAbility: humanMathMock);
  });

  test('human will be puzzled when solves math problem', () {
    human.askMathQuestion(MathOperator.DIVISION, 5123, 744);
    verify(emotionsMock.puzzled());
  });

  test('human solves math tasks not instantly', () {
    final computation =
        human.askMathQuestion(MathOperator.SUBTRACTION, 6543, 234);
    verify(humanMathMock.compute(MathOperator.SUBTRACTION, 6543, 234));

    final result = computation is Future<num> ? true : false;

    expect(result, true);
  });
}
