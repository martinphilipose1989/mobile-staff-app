import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorListPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;
  final BehaviorSubject<int> selectValue = BehaviorSubject.seeded(-1);

  VisitorListPageViewModel({required this.exceptionHandlerBinder});

  onToggleSelect() {}
}
