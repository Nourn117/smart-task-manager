import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:smart_task_manager/core/network/network_info.dart';

import '../../helpers/mocks.dart';

void main() {
  late MockConnectivity connectivity;
  late NetworkInfo networkInfo;

  setUp(() {
    connectivity = MockConnectivity();
    networkInfo = NetworkInfo(connectivity);
  });

  test('is connected when any network interface is available', () async {
    when(() => connectivity.checkConnectivity()).thenAnswer(
      (_) async => [ConnectivityResult.none, ConnectivityResult.mobile],
    );

    expect(await networkInfo.isConnected(), isTrue);
  });

  test('is not connected when there is no network interface', () async {
    when(() => connectivity.checkConnectivity())
        .thenAnswer((_) async => [ConnectivityResult.none]);

    expect(await networkInfo.isConnected(), isFalse);
  });

  test('reports only actual status changes', () {
    when(() => connectivity.onConnectivityChanged).thenAnswer(
      (_) => Stream.fromIterable([
        [ConnectivityResult.wifi],
        [ConnectivityResult.wifi, ConnectivityResult.mobile],
        [ConnectivityResult.none],
        [ConnectivityResult.mobile],
      ]),
    );

    expect(networkInfo.onStatusChanged, emitsInOrder([true, false, true]));
  });
}
