import 'package:unit_test_article/replicant/replicant_interfaces.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:unit_test_article/survey.dart';
import 'fixtures/fixture_reader.dart';

/*
Remote data source comes with the client property in init method
Client is the third party dependency so we create a mock from it
in order to simulate the behaviour of real object.
*/
class HttpClientMock extends Mock implements http.Client {}

main() {
  HttpClientMock httpClientMock;
  RemoteDataSource remoteDataSource;

  setUp(() {
    httpClientMock = HttpClientMock();
    remoteDataSource = RemoteDataSource(client: httpClientMock);
  });

  //Create a group of related tests to run
  group('remote data source check', () {
    final question = GeneralQuestion.ASTRONOMY;
    final answerModel = Answer(text: 'Test text');

    //actual test with the description
    test('returns back bad response if http status code 404', () async {
      /* arrange – when mock will call the get method then
         then answer with 404 response 
      */
      when(httpClientMock.get(any)).thenAnswer(
        (_) async => http.Response('Bad response', 404),
      );

      //actually call the remoteDataSource request
      final call = remoteDataSource.request;

      //prvide actual result and matcher to see if test has passed
      expect(() => call(question), throwsA(isInstanceOf<Exception>()));
    });

    test('returns Answer model if http status code 200', () async {
      //arrange
      when(httpClientMock.get(any)).thenAnswer((_) async {
        return http.Response(fixture('answer.json'), 200);
      });

      //act
      final result = await remoteDataSource.request(question);

      //assert
      expect(result, answerModel);
    });
  });
}
