// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:saypay/core/const/app_constant.dart';
import 'package:saypay/core/routes/routes_constant.dart';
import 'package:saypay/features/view/view.dart';

import '../../../services/storage/local_storage.dart';

class OnBoardView extends StatefulWidget {
  const OnBoardView({super.key});

  @override
  State<OnBoardView> createState() => _OnBoardViewState();
}

class _OnBoardViewState extends State<OnBoardView> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  final service = SplashServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: SafeArea(
        child: Column(
          children: [
            /// PageView
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingData.length,
                onPageChanged: (index) {
                  setState(() => currentIndex = index);
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// Image
                      Image.asset(
                        onboardingData[index]["image"]!,
                        height: 467,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),

                      /// Title
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          onboardingData[index]["title"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 29,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 23),
                      Text(
                        onboardingData[index]["subtitle"]!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),

                      /// Subtitle
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: List.generate(
                      onboardingData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(4),
                        width: currentIndex == index ? 20 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: currentIndex == index
                              ? const Color.fromARGB(235, 213, 188, 142)
                              : Colors.black38.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (currentIndex == onboardingData.length - 1) {
                        final LocalStorage storage = LocalStorage();
                        await storage.setValue(
                          'isFirstTime',
                          'false',
                        ); // Mark onboarding as done

                        if (context.mounted) {
                          Navigator.pushReplacementNamed(
                            context,
                            RoutesConstant.login,
                          );
                        }

                        // Navigate to Home
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    child: Container(
                      height: 43,
                      width: 43,

                      decoration: BoxDecoration(
                        color: const Color.fromARGB(235, 213, 188, 142),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
