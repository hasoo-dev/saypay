import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:saypay/core/utils/size_extension/size_ext.dart';

import '../../../services/profile_services/currency_controller.dart';
import '../main/widget/currency_tile.dart';

class Currency extends StatefulWidget {
  const Currency({super.key});

  @override
  State<Currency> createState() => _CurrencyState();
}

class _CurrencyState extends State<Currency> {
  final CurrencyController _currencyController = Get.put(CurrencyController(), permanent: true);

  final List<Map<String, String>> _currencies = [
    {'code': 'USD', 'symbol': '\$', 'name': 'United States Dollar'},
    {'code': 'PKR', 'symbol': '₨', 'name': 'Pakistani Rupee'},
    {'code': 'EUR', 'symbol': '€', 'name': 'Euro'},
    {'code': 'GBP', 'symbol': '£', 'name': 'British Pound'},
    {'code': 'JPY', 'symbol': '¥', 'name': 'Japanese Yen'},
    {'code': 'CAD', 'symbol': '\$', 'name': 'Canadian Dollar'},
    {'code': 'AUD', 'symbol': '\$', 'name': 'Australian Dollar'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onPrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back_ios_new, color:  Theme.of(context).colorScheme.primaryFixed,size: 20,),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Currency",
                      style: theme.textTheme.headlineLarge!.copyWith(
                        fontSize: 38,
                        fontWeight: FontWeight.w800,
                        color:  Theme.of(context).colorScheme.primary,
                        letterSpacing: -1,
                      ),
                    ),
                    0.01.vSpace,
                    Text(
                      "Choose your preferred currency. This will be used across your transactions and budgets.",
                      style: theme.textTheme.bodyMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                    0.04.vSpace,
                    
                    // Currencies List
                    Obx(() {
                      final selected = _currencyController.selectedCurrency.value;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _currencies.length,
                        itemBuilder: (context, index) {
                          return CurrencyTile(
                            currency: _currencies[index],
                            isSelected: selected == _currencies[index]['code'],
                            onTap: () {
                              _currencyController.setCurrency(_currencies[index]['code']!);
                            },
                          );
                        },
                      );
                    }),
                    
                    0.04.vSpace,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

