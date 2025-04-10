import 'package:flutter/material.dart';
/* import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:teslo_app/features/auth/presentation/providers/auth_provider.dart';
 *///ConsumerWidget
class CheckAuthStatusScreem extends StatelessWidget  {
  const CheckAuthStatusScreem({super.key});

  @override
  Widget build(BuildContext context) {
    //, WidgetRef ref
   /*  ref.listen(authProvider, (previous, next) {
      context.go('/')
    }); */

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
  }
}
