import 'dart:developer';

import 'package:app/utils/common_widgets/toggle_option_list.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorListPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final selectedStatus = BehaviorSubject<int>.seeded(-1);
  final statusTypeList = [
    const ToggleOption<int>(value: 0, text: "IN"),
    const ToggleOption<int>(value: 1, text: "OUT")
  ];

  VisitorListPageViewModel({required this.exceptionHandlerBinder});

  void onVisitStatusSelect({required int selectStatus}) {
    log("message");
  }
}
