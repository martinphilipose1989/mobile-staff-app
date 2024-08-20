import 'dart:async';
import 'dart:developer';

import 'package:app/model/resource.dart';
import 'package:app/utils/common_widgets/toggle_option_list.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorListPageViewModel extends BasePageViewModel {
  final FlutterExceptionHandlerBinder _exceptionHandlerBinder;
  final GetVisitorListUsecase _getVisitorListUsecase;
  final PublishSubject<Resource<VisitorListResponseModel>>
      _visitorListResponse = PublishSubject();

  Stream<Resource<VisitorListResponseModel>> get visitorListResponse =>
      _visitorListResponse.stream;

  final selectedStatus = BehaviorSubject<int>.seeded(-1);
  final statusTypeList = [
    const ToggleOption<int>(value: 0, text: "IN"),
    const ToggleOption<int>(value: 1, text: "OUT")
  ];

  final TextEditingController searchController = TextEditingController();

  final _loadingSubject = BehaviorSubject<bool>.seeded(false);
  final hasMorePagesSubject = BehaviorSubject<bool>.seeded(true);
  final _pageSubject = BehaviorSubject<int>.seeded(1);
  final _visitorListSubject =
      BehaviorSubject<List<VisitorDataModel>>.seeded([]);

  Stream<bool> get loadingStream => _loadingSubject.stream;
  Stream<bool> get hasMorePagesStream => hasMorePagesSubject.stream;
  Stream<List<VisitorDataModel>> get visitorListStream =>
      _visitorListSubject.stream;

  final _throttleDuration = const Duration(milliseconds: 300);

  VisitorListPageViewModel({
    required FlutterExceptionHandlerBinder exceptionHandlerBinder,
    required GetVisitorListUsecase getVisitorListUsecase,
  })  : _exceptionHandlerBinder = exceptionHandlerBinder,
        _getVisitorListUsecase = getVisitorListUsecase {
    _setupThrottling();
  }

  void onVisitStatusSelect({required int selectStatus}) {
    selectedStatus.add(selectStatus);
    refreshVisitorList(); // Trigger list refresh on status change
  }

  void refreshVisitorList() {
    _pageSubject.add(1);
    _visitorListSubject.add([]);
    hasMorePagesSubject.add(true);
    getVisitorList();
  }

  void getVisitorList() {
    if (_visitorListSubject.isClosed) return;
    if (_loadingSubject.value || !hasMorePagesSubject.value) return;

    if (_pageSubject.value > 1) {
      _loadingSubject.add(true);
    }

    _exceptionHandlerBinder.handle(block: () {
      final params =
          GetVisitorListUsecaseParams(pageNumber: _pageSubject.value);
      return RequestManager<VisitorListResponseModel>(
        params,
        createCall: () => _getVisitorListUsecase.execute(params: params),
      ).asFlow().listen((result) {
        if (_pageSubject.value == 1) {
          _visitorListResponse.add(result);
        } else {
          _loadingSubject.add(true);
        }

        if (result.status == Status.success) {
          final visitors = result.data?.visitorListDataModel?.visitors ?? [];
          final isNextPage =
              result.data?.visitorListDataModel?.isNextPage ?? false;

          if (_pageSubject.value == 1) {
            _visitorListSubject.add(visitors);
          } else {
            _visitorListSubject
                .add([..._visitorListSubject.value, ...visitors]);
          }
          hasMorePagesSubject.add(isNextPage);
        }

        _loadingSubject.add(false);
      }).onError((error) {
        log("Error fetching visitor list: $error");
        _loadingSubject.add(false);
      });
    }).execute();
  }

  void loadMoreVisitorList() {
    _throttlingController.add(null); // Trigger the throttle stream
  }

  final StreamController<void> _throttlingController = StreamController<void>();

  void _setupThrottling() {
    // Listen to the throttling stream once
    _throttlingController.stream.throttleTime(_throttleDuration).listen((_) {
      if (!_loadingSubject.value && hasMorePagesSubject.value) {
        _pageSubject.add(_pageSubject.value + 1);
        getVisitorList();
      }
    });
  }

  @override
  void dispose() {
    _pageSubject.close();
    _visitorListSubject.close();
    _loadingSubject.close();
    hasMorePagesSubject.close();
    selectedStatus.close();
    searchController.dispose();
    _throttlingController.close();
    super.dispose();
  }
}
