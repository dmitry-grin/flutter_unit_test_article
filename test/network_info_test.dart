import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:unit_test_article/replicant/replicant_interfaces.dart';

class ConnectionCheckerMock extends Mock implements DataConnectionChecker {}

main() {
  //nested entity in ReplicantsRepository
  ConnectionCheckerMock connectionCheckerMock;
  NetworkInfo networkInfo;

  setUp(() {
    connectionCheckerMock = ConnectionCheckerMock();
    networkInfo = NetworkInfo(connectionChecker: connectionCheckerMock);
  });

  test('replicant connectivity checker behaves as expected', () async {
    // 1 stub the response
    final hasConnectionStub = Future.value(true);

    // 2 when mock calls hasConnection getter return stub
    when(connectionCheckerMock.hasConnection)
        .thenAnswer((realInvocation) => hasConnectionStub);

    // 3 act
    final result = networkInfo.isConnected;

    // 4 verify that hasConnection getter actually called
    verify(connectionCheckerMock.hasConnection);

    // 5 assert the result
    expect(result, hasConnectionStub);
  });
}
