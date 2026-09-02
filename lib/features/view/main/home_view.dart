import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:saypay/core/const/app_constant.dart';
import 'package:saypay/core/theme/app_colors.dart';
import 'package:saypay/core/utils/size_extension/size_ext.dart';
import 'package:saypay/services/auth_services.dart/auth_services.dart';
import 'package:saypay/services/session_controller/session_controller.dart';

import '../../../core/utils/ui_utils/ui_utils.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final authservices = Get.find<AuthService>();
  final session = Get.find<SessionController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              SizedBox(height: 0.02.h),
              Obx(() {
                final avatar = session.avatarUrl.value;
                final userName = session.fullName.value.isNotEmpty
                    ? session.fullName.value
                    : "Unknown";

                return Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Welcome",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 30,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primaryFixed,
                            ),
                          ),
                          TextSpan(
                            text: "\n$userName to Spendly ",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.primaryFixed,
                            ),
                          ),
                          TextSpan(
                            text:
                                "\nWhere you can track your all your\ntransaction of the everday ",
                            style: theme.textTheme.bodyMedium!.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w200,
                              overflow: TextOverflow.ellipsis,
                              color: theme.colorScheme.primaryFixed,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 13),
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.primary.withOpacity(0.2),
                          width: 3,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 0.05.h,
                        backgroundColor: Colors.grey.shade200,
                        // ✅ Now reads from reactive value — updates instantly
                        backgroundImage: avatar.isNotEmpty
                            ? NetworkImage(avatar)
                            : const AssetImage(AppConstant.profile)
                                  as ImageProvider,
                      ),
                    ),
                  ],
                );
              }),
              SizedBox(height: 0.02.h),

              Text(
                "All Transactions ",
                style: theme.textTheme.bodyMedium!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primaryFixed,
                ),
              ),
              SizedBox(height: 0.02.h),
              historySection(),
              SizedBox(height: 0.02.h),
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Text(
                    "History",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.primaryFixed,
                    ),
                  ),
                  PopupMenuButton<String>(
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                          value: "Day",
                          child: Text("Day"),
                        ),
                        PopupMenuItem(
                          value: "Week",
                          child: Text("Week"),
                        ),
                        PopupMenuItem(
                          value: "Month",
                          child: Text("Month"),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      
                      UiUtils.showFlushbar(context, "Menu tapped");
                    },
                    icon: Icon(
                      Icons.menu_sharp,
                      size: 32,
                      color: theme.colorScheme.primaryFixed,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 512,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      margin: EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(34),
                      ),
                      child: ListTile(
                        title: Text(
                          "Transaction ${index + 1}",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.primary,
                              ),
                        ),
                        leading: CircleAvatar(
                          radius: 0.02.h,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: const AssetImage(
                            AppConstant.profile,
                          ),
                        ),
                        subtitle: Text(
                          " Category : Food",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontSize: 12,
                                fontWeight: FontWeight.w200,
                                color: theme.colorScheme.primary,
                              ),
                        ),
                        trailing: Text(
                          "PKR 100",
                          style: Theme.of(context).textTheme.bodyMedium!
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: theme.colorScheme.primary,
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget historySection() {
    return Container(
      height: 0.34.h,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomCenter,
          colors: [Colors.grey, AppColors.primary.withValues(alpha: .6)],
        ),
        borderRadius: BorderRadius.circular(34),
      ),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          Image.asset('assets/icons/ic_total.png', height: 40, width: 40),
          SizedBox(height: 0.01.h),
          Text(
            "Total Amount",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primaryFixed,
            ),
          ),
          SizedBox(height: 0.01.h),
          Text(
            "2000 PKR",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 56,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primaryFixed,
            ),
          ),

          SizedBox(height: 0.02.h),

          Column(
            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .start,
                children: [
                  Text(
                    "Expense Amount",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.primaryFixed,
                    size: 23,
                  ),
                  Text(
                    "345.300 PKR",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .end,
                children: [
                  Text(
                    "Remaining Amount",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward,
                    color: Theme.of(context).colorScheme.primaryFixed,
                    size: 23,
                  ),

                  Text(
                    "345.300 PKR",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primaryFixed,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
