import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:saypay/core/const/app_constant.dart';
import '../view.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final splashservices = SplashServices();
  @override
  void initState() {
    super.initState();
    if (mounted) {
      splashservices.navigateToNextScreen(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: FadeIn(
        delay: Duration(seconds: 2),
        duration: Duration(seconds: 2),
        child: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: .center,
                  children: [
                    Image.asset(AppConstant.logo, width: 132),
                    const SizedBox(height: 2),
                    Text(
                      AppConstant.appName,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 34,
                        color: Theme.of(context).colorScheme.primaryFixed,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              //Branding Text for the app Spendly
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    AppConstant.branding,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
