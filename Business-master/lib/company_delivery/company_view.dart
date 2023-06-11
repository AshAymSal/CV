import 'package:business/company_delivery/model/company_model.dart';
import 'package:business/widget/button/custom_button.dart';
import 'package:business/widget/custom_appbar.dart';
import 'package:business/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'company_delivery_viewmodel.dart';

class CompanyView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, watch) {
    final viewModel = watch(companyDeliveryViewModel);
    return Scaffold(
      appBar: customAppBar(title: 'الشحن') as PreferredSizeWidget?,
      body: SafeArea(
        child: LoadingStack(
          isLoading: viewModel.isLoading,
          child: SingleChildScrollView(
            child: Container(
              child: ExpansionPanelList(
                expandedHeaderPadding: EdgeInsets.all(10),
                expansionCallback: viewModel.changeIsExpanded,
                children: viewModel.companiesModelList!
                    .map<ExpansionPanel>((CompanyModel company) {
                  return ExpansionPanel(
                    headerBuilder: (context, isExpanded) {
                      return Container(
                        padding: EdgeInsets.all(20),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30.0,
                            backgroundImage: NetworkImage(
                              company.image!.isNotEmpty
                                  ? company.image!
                                  : "https://thumbor.thedailymeal.com/2-csdMr9QHHyM6VFOZzjfeBW1qs=/870x565/https://www.thedailymeal.com/sites/default/files/slideshows/1945731/2111484/17_Chewing_with_mouht_open_slide_Eit.jpg",
                            ),
                            backgroundColor: Colors.transparent,
                          ),
                          title: Text(company.name!),
                          onTap: () {},
                        ),
                      );
                    },
                    body: Column(
                      children: [
                        ...List.generate(
                            company.phones!.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(" - " + company.phones![index]),
                                      CustomButton(
                                        text: "اتصال",
                                        onPressed: () {
                                          viewModel.makingPhoneCall(
                                              company.phones![index]);
                                        },
                                        textColor: Colors.white,
                                      ),
                                    ],
                                  ),
                                ))
                      ],
                    ),
                    isExpanded: company.isExpanded!,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
