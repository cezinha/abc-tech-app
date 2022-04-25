import 'package:abctechapp/model/assistance.dart';
import 'package:abctechapp/provider/assistance_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AssistanceServiceInterface {
  Future<List<Assistance>> getAssists();
  Future<AssistanceServiceInterface> init(AssistanceProviderInterface provider);
}

class AssistanceService extends GetxService
    implements AssistanceServiceInterface {
  late AssistanceProviderInterface _assistanceProvider;

  @override
  Future<List<Assistance>> getAssists() async {
    Response response = await _assistanceProvider.getAssists();
    if (response.hasError) {
      return Future.error(ErrorDescription("Erro na conexão"));
    }
    try {
      List<Assistance> listResult = response.body
          .map<Assistance>((item) => Assistance.fromMap(item))
          .toList();

      return Future.sync(() => listResult);
    } catch (e) {
      e.printInfo();
      return Future.error(ErrorDescription("Erro não esperado"));
    }
  }

  @override
  Future<AssistanceServiceInterface> init(
      AssistanceProviderInterface provider) async {
    _assistanceProvider = provider;
    return this;
  }
}
