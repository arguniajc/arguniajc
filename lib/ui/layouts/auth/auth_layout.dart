import 'package:control_actividades/ui/layouts/auth/widgets/background_twitter.dart';
import 'package:control_actividades/ui/layouts/auth/widgets/custom_title.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {
  final Widget child;

  const AuthLayout({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Scrollbar(
      // isAlwaysShown: true,
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          (size.height > 700 && size.width > 1000)
              ? _DesktopBody(child: child)
              : _MobileBody(child: child),

          // LinksBar
          //LinksBar()
        ],
      ),
    ));
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;

  const _MobileBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 950,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          CustomTitle(),
          SizedBox(
            width: double.infinity,
            height: 650,
            child: child,
          )
        ],
      ),
    );
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;

  const _DesktopBody({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      color: Colors.white,
      child: Row(
        children: [
          // Twitter Background
          Expanded(child: BackgroundTwitter()),

          // View Container
          Container(
            width: 700,
            height: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTitle(),
                Expanded(child: child),
              ],
            ),
          )
        ],
      ),
    );
  }
}
