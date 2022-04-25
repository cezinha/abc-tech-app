import 'package:abctechapp/model/assistance.dart';
import 'package:abctechapp/services/assistance_service.dart';
import 'package:get/get.dart';

class AssistanceController extends GetxController
    with StateMixin<List<Assistance>> {
  late AssistanceServiceInterface _service;
  List<Assistance> allAssists = [];
  List<Assistance> selectedAssists = [];

  @override
  void onInit() {
    super.onInit();
    _service = Get.find<AssistanceServiceInterface>();
    selectedAssists = Get.arguments;

    getAssistanceList();
  }

  void getAssistanceList() {
    change([], status: RxStatus.loading());
    _service.getAssists().then((value) {
      allAssists = value;
      change(value, status: RxStatus.success());
    }).onError((error, stackTrace) {
      change([], status: RxStatus.error(error.toString()));
    });
  }

  bool isSelected(int index) {
    Assistance assistance = allAssists[index];
    int indexFound =
        selectedAssists.indexWhere((element) => element.id == assistance.id);
    return indexFound != -1;
  }

  void selectAssist(int index) {
    if (!isSelected(index)) {
      selectedAssists.add(allAssists[index]);
    } else {
      selectedAssists.remove(allAssists[index]);
    }

    change(allAssists, status: RxStatus.success());
  }
}
