import 'package:app/utils/common_widgets/toggle_option_list.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/subjects.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class TransportDashboardPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder exceptionHandlerBinder;

  final BehaviorSubject<String> selectedTripStatus = BehaviorSubject.seeded("");

  final tripStatusType = [
    const ToggleOption<String>(
        value: "up coming trips", text: "Upcoming Trips"),
    const ToggleOption<String>(
        value: "completed trips", text: "Incompleted Trips")
  ];

  TransportDashboardPageViewModel({required this.exceptionHandlerBinder});
}
