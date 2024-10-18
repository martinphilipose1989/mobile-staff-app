import 'package:app/model/resource.dart';
import 'package:app/molecules/school_contact/school_contact_card.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
import 'package:app/utils/common_widgets/no_data_found_widget.dart';
import 'package:app/utils/data_status_widget.dart';
import 'package:app/utils/stream_builder/app_stream_builder.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:statemanagement_riverpod/statemanagement_riverpod.dart';
import 'school_contacts_page_viewmodel.dart';

class SchoolContactsPageView
    extends BasePageViewWidget<SchoolContactsPageViewModel> {
  // ignore: use_super_parameters
  SchoolContactsPageView(ProviderBase<SchoolContactsPageViewModel> model)
      : super(model);

  @override
  Widget build(BuildContext context, SchoolContactsPageViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CommonText(
              text: "School Contact Details", style: AppTypography.subtitle2),
        ),
        Expanded(
            child: AppStreamBuilder<Resource<List<SchoolResponse>>>(
          stream: model.schoolContactSubject.stream,
          initialData: Resource.none(),
          dataBuilder: (context, schoolContact) {
            return DataStatusWidget(
              status: schoolContact?.status ?? Status.none,
              loadingWidget: () =>
                  const Center(child: CircularProgressIndicator()),
              successWidget: () => ListView.builder(
                itemCount: schoolContact?.data?.length,
                prototypeItem: const SchoolContactCard(),
                itemBuilder: (context, index) {
                  return const SchoolContactCard();
                },
              ),
              errorWidget: () => Center(
                child: NoDataFoundWidget(
                  title: schoolContact?.dealSafeAppError?.error.message
                              .contains("internet") ??
                          false
                      ? "No Internet Connection"
                      : "Something Went Wrong",
                  subtitle: schoolContact?.dealSafeAppError?.error.message
                              .contains("internet") ??
                          false
                      ? "It seems you're offline. Please check your internet connection and try again."
                      : "An unexpected error occurred. Please try again later or contact support if the issue persists.",
                  onPressed: () {
                    // model.refreshVisitorList();
                  },
                ),
              ),
            );
          },
        )),
      ],
    );
  }
}
