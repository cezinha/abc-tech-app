import 'dart:convert';
import 'dart:io';

import 'package:abctechapp/model/assistance.dart';
import 'package:abctechapp/provider/assistance_provider.dart';
import 'package:abctechapp/services/assistance_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_connect.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'assistance_service_test.mocks.dart';

@GenerateMocks([AssistanceProviderInterface])
void main() {
  late AssistanceServiceInterface service;
  late MockAssistanceProviderInterface provider;
  setUp(() async {
    provider = MockAssistanceProviderInterface();
    service = await AssistanceService().init(provider);
    var json = File(
            Directory.current.path + "/test/resources/assistance_response.json")
        .readAsStringSync();

    when(provider.getAssists()).thenAnswer((_) async => Future.sync(
        () => Response(statusCode: HttpStatus.ok, body: jsonDecode(json))));
  });

  test('Testando a assistance service', () async {
    List<Assistance> retorno = await service.getAssists();
    expect(retorno.length, 6);
  });
}
