import 'dart:async';

import 'package:app/model/resource.dart';
import 'package:app/myapp.dart';
import 'package:app/navigation/route_paths.dart';
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
  final LogoutUsecase _logoutUsecase;

  final selectedStatus = BehaviorSubject<String>.seeded("In");
  final selectedVisitStatusFilter = BehaviorSubject<String>.seeded("");

  final statusTypeList = [
    const ToggleOption<String>(value: "In", text: "In"),
    const ToggleOption<String>(value: "Out", text: "Out")
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

  final BehaviorSubject<String> _searchQuerySubject = BehaviorSubject<String>();
  final Duration _debounceDuration = const Duration(milliseconds: 500);

  final selectedTypeOfVisitor = BehaviorSubject<String>.seeded("");

  final BehaviorSubject<Resource<List<MdmCoReasonDataModel>>>
      _typeOfVisitorListSubject = BehaviorSubject.seeded(Resource.none());

  Stream<Resource<List<MdmCoReasonDataModel>>> get typeOfVisitorListStream =>
      _typeOfVisitorListSubject.stream;

  final BehaviorSubject<bool> isFilterAppliedSubject =
      BehaviorSubject<bool>.seeded(false);
  Stream<bool> get isFilterAppLiedStream => isFilterAppliedSubject.stream;

  final BehaviorSubject<bool> isButtonDisableSubject =
      BehaviorSubject<bool>.seeded(true);

  Stream<bool> get isButtonDisableStream => isButtonDisableSubject.stream;

  FocusNode focusNode = FocusNode();

  BehaviorSubject<String> hinText =
      BehaviorSubject.seeded("Search by Name,Email,Contact");

  void onFocusChange() {
    // if (focusNode.hasFocus) {
    //   hinText.add("Search by Name,Email,Contact");
    // } else {
    //   hinText.add("Search Visitor");
    // }
  }

  VisitorListPageViewModel(
      {required FlutterExceptionHandlerBinder exceptionHandlerBinder,
      required GetVisitorListUsecase getVisitorListUsecase,
      required GetTypeOfVisitorListUsecase getTypeOfVisitorListUsecase,
      required LogoutUsecase logoutUsecase})
      : _exceptionHandlerBinder = exceptionHandlerBinder,
        _getVisitorListUsecase = getVisitorListUsecase,
        _getTypeOfVisitorListUsecase = getTypeOfVisitorListUsecase,
        _logoutUsecase = logoutUsecase {
    _setupThrottling();
    getTypeofVisitorList();
    _setupDebouncedSearch();
  }

  void onVisitStatusSelect({required String selectStatus}) {
    selectedStatus.add(selectStatus);
    refreshVisitorList();
  }

  Future<void> refreshVisitorList() async {
    _pageSubject.add(1);
    searchController.clear();
    _visitorListSubject.add(Resource.success(data: []));
    hasMorePagesSubject.add(true);
    _loadingSubject.add(false);

    fetchVisitorList();
  }

  void loadMoreVisitorList() {
    if (_visitorListSubject.value.data?.isNotEmpty ?? false) {
      _throttlingController.add(null);
    }
  }

  final StreamController<void> _throttlingController = StreamController<void>();

  void _setupThrottling() {
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
            search:
                searchController.text.isEmpty ? null : searchController.text,
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
                    search: int.parse(selectedTypeOfVisitor.value))
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
    if (result.status == Status.error) {
      _visitorListSubject
          .add(Resource.error(data: null, error: result.dealSafeAppError));
      return;
    }

    final isNextPage = result.data?.visitorListDataModel?.isNextPage ?? false;
    final visitors = result.data?.visitorListDataModel?.visitors ?? [];

    _shouldNotFetchVisitors();

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
    RequestManager<MdmCoReasonResponseModel>(
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

  void resetFilter() {
    selectedStatus.add("In");
    selectedTypeOfVisitor.add("");
    selectedVisitStatusFilter.add("");
    isFilterAppliedSubject.add(false);
    isButtonDisableSubject.add(true);
    refreshVisitorList();
  }

  void applyFilters() {
    selectedStatus.add(selectedVisitStatusFilter.value);
    isFilterAppliedSubject.add(true);
    refreshVisitorList();
  }

  void searchVisitorList({required String query}) {
    // Add the search query to the debouncing stream
    _searchQuerySubject.add(query);
  }

  void _setupDebouncedSearch() {
    _searchQuerySubject.debounceTime(_debounceDuration).listen((searchQuery) {
      if (searchQuery.isEmpty || searchQuery.length < 3) {
        return;
      }

      _pageSubject.add(1);
      _visitorListSubject.add(Resource.success(data: []));
      hasMorePagesSubject.add(true);
      _loadingSubject.add(false);

      fetchVisitorListWithSearch(searchQuery);
    });
  }

  void fetchVisitorListWithSearch(String searchQuery) {
    _exceptionHandlerBinder.handle(block: () {
      final params = GetVisitorListUsecaseParams(
        requestBody: GetVisitorListRequestModel(
            pageNumber: _pageSubject.value,
            pageSize: pageSize,
            search: searchQuery,
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
                    search: int.parse(selectedTypeOfVisitor.value))
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

  void logOut() {
    final LogoutUsecaseParams params = LogoutUsecaseParams();
    RequestManager(params,
            createCall: () => _logoutUsecase.execute(params: params))
        .asFlow()
        .listen((data) {
      if (data.status == Status.success) {
        navigatorKey.currentState!
            .pushNamedAndRemoveUntil(RoutePaths.splash, (route) => false);
      }
    }, onDone: () {}, onError: (error) {});
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
    _searchQuerySubject.close();
    super.dispose();
  }
}
