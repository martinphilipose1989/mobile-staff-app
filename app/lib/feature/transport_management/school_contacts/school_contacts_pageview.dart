import 'package:app/molecules/school_contact/school_contact_card.dart';
import 'package:app/utils/app_typography.dart';
import 'package:app/utils/common_widgets/common_text_widget.dart';
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
          child: ListView.builder(
            itemCount: 15,
            prototypeItem: const SchoolContactCard(),
            itemBuilder: (context, index) {
              return const SchoolContactCard();
            },
          ),
        ),
      ],
    );
  }
}
