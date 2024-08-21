import 'dart:async';

import 'package:app/model/resource.dart';
import 'package:app/utils/common_widgets/toggle_option_list.dart';
import 'package:app/utils/request_manager.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_errors/flutter_errors.dart';
import 'package:rxdart/rxdart.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';

class VisitorListPageViewModel extends BasePageViewModel {
  final int pageSize = 10;
  final FlutterExceptionHandlerBinder _exceptionHandlerBinder;
  final GetVisitorListUsecase _getVisitorListUsecase;
  final GetTypeOfVisitorListUsecase _getTypeOfVisitorListUsecase;

  final selectedStatus = BehaviorSubject<String>.seeded("");
  final statusTypeList = [
    const ToggleOption<String>(value: "In", text: "IN"),
    const ToggleOption<String>(value: "Out", text: "OUT")
  ];

  final TextEditingController searchController = TextEditingController();

  final _loadingSubject = BehaviorSubject<bool>.seeded(false);
  final hasMorePagesSubject = BehaviorSubject<bool>.seeded(true);
  final _pageSubject = BehaviorSubject<int>.seeded(1);
  final _visitorListSubject =
      BehaviorSubject<Resource<List<VisitorDataModel>>>.seeded(Resource.none());

  Stream<bool> get loadingStream => _loadingSubject.stream;
  Stream<bool> get hasMorePagesStream => hasMorePagesSubject.stream;
  Stream<Resource<List<VisitorDataModel>>> get visitorListStream =>
      _visitorListSubject.stream;

  final _throttleDuration = const Duration(milliseconds: 300);

  final selectedTypeOfVisitor = BehaviorSubject<String>.seeded("");

  final BehaviorSubject<Resource<List<TypeOfVisitorDataModel>>>
      _typeOfVisitorListSubject = BehaviorSubject.seeded(Resource.none());

  Stream<Resource<List<TypeOfVisitorDataModel>>> get typeOfVisitorListStream =>
      _typeOfVisitorListSubject.stream;

  final BehaviorSubject<bool> isFilterAppliedSubject = BehaviorSubject<bool>();
  Stream<bool> get isFilterAppLiedStream => isFilterAppliedSubject.stream;

  VisitorListPageViewModel(
      {required FlutterExceptionHandlerBinder exceptionHandlerBinder,
      required GetVisitorListUsecase getVisitorListUsecase,
      required GetTypeOfVisitorListUsecase getTypeOfVisitorListUsecase})
      : _exceptionHandlerBinder = exceptionHandlerBinder,
        _getVisitorListUsecase = getVisitorListUsecase,
        _getTypeOfVisitorListUsecase = getTypeOfVisitorListUsecase {
    _setupThrottling();
    getTypeofVisitorList();
  }

  void onVisitStatusSelect({required String selectStatus}) {
    selectedStatus.add(selectStatus);
    refreshVisitorList(); // Trigger list refresh on status change
  }

  void refreshVisitorList() {
    _pageSubject.add(1);
    _visitorListSubject.add(Resource.success(data: []));
    hasMorePagesSubject.add(true);
    _loadingSubject.add(false);

    fetchVisitorList();
  }

  void loadMoreVisitorList() {
    if (_visitorListSubject.value.data?.isNotEmpty ?? false) {
      _throttlingController.add(null); // Trigger the throttle stream
    }
  }

  final StreamController<void> _throttlingController = StreamController<void>();

  void _setupThrottling() {
    // Listen to the throttling stream once
    _throttlingController.stream.throttleTime(_throttleDuration).listen((_) {
      if (!_loadingSubject.value && hasMorePagesSubject.value) {
        _pageSubject.add(_pageSubject.value + 1);
        fetchVisitorList();
      }
    });
  }

  bool _shouldNotFetchVisitors() {
    return _visitorListSubject.isClosed ||
        _loadingSubject.value ||
        !hasMorePagesSubject.value;
  }

  void fetchVisitorList() {
    if (_shouldNotFetchVisitors()) return;

    if (_pageSubject.value > 1) {
      _loadingSubject.add(true);
    }

    _exceptionHandlerBinder.handle(block: () {
      final params = GetVisitorListUsecaseParams(
        requestBody: GetVisitorListRequestModel(
            pageNumber: _pageSubject.value,
            pageSize: pageSize,
            filters: [
              if (selectedStatus.value.isNotEmpty) ...{
                FilterRequestModel(
                    column: "visit_status",
                    operation: "equals",
                    search: selectedStatus.value)
              },
              if (selectedTypeOfVisitor.value.isNotEmpty) ...{
                FilterRequestModel(
                    column: "visitor_type_id",
                    operation: "equals",
                    search: selectedTypeOfVisitor.value)
              }
            ]),
      );
      return RequestManager<VisitorListResponseModel>(
        params,
        createCall: () => _getVisitorListUsecase.execute(params: params),
      ).asFlow().listen((result) {
        _handleVisitorListResponse(result);
      }).onError((error) {
        _loadingSubject.add(false);
      });
    }).execute();
  }

  void _handleVisitorListResponse(Resource<VisitorListResponseModel> result) {
    final isNextPage = result.data?.visitorListDataModel?.isNextPage ?? false;
    final visitors = result.data?.visitorListDataModel?.visitors ?? [];

    if (_pageSubject.value == 1) {
      _visitorListSubject.add(Resource.loading(data: null));
    }

    if (result.status == Status.success) {
      _updateVisitorList(visitors, isNextPage);
    }
  }

  void _updateVisitorList(List<VisitorDataModel> visitors, bool isNextPage) {
    if (_pageSubject.value == 1) {
      _visitorListSubject.add(Resource.success(data: visitors));
    } else {
      final List<VisitorDataModel> updatedList = [
        ..._visitorListSubject.value.data ?? <VisitorDataModel>[],
        ...visitors
      ];
      _visitorListSubject.add(Resource.success(data: updatedList));
    }
    hasMorePagesSubject.add(isNextPage);
    _loadingSubject.add(false);
  }

  getTypeofVisitorList() {
    GetTypeOfVisitorListUsecaseParams params =
        GetTypeOfVisitorListUsecaseParams();
    RequestManager<TypeOfVisitorResponseModel>(
      params,
      createCall: () => _getTypeOfVisitorListUsecase.execute(params: params),
    ).asFlow().listen(
      (result) {
        if (Status.success == result.status) {
          _typeOfVisitorListSubject
              .add(Resource.success(data: result.data?.data));
        }
      },
      onError: (error) {},
    );
  }

  void setTypeofVistor({required String typeOfVisitorId}) {
    selectedTypeOfVisitor.add(typeOfVisitorId);
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
    selectedTypeOfVisitor.close();
    super.dispose();
  }
}
