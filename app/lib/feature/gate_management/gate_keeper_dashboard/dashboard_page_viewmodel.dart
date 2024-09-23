import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/subjects.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class DashboardPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;

  final BehaviorSubject<int> selectedIndex = BehaviorSubject.seeded(0);

  final BehaviorSubject<String> selectedSatus = BehaviorSubject.seeded("");

  DashboardPageViewModel({required this.exceptionHandlerBinder});

  void selectDashboardItem({required int index}) {
    if (index == 0) {
      selectedIndex.value = index;
    } else if (index == 1) {
      selectedIndex.value = index;
    } else if (index == 2) {
      selectedIndex.value = index;
    }
  }
}
