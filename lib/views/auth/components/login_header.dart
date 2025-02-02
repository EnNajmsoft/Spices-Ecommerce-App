import 'package:flutter/material.dart';
import '../../../core/components/network_image.dart';
import '../../../core/constants/constants.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textGradient = LinearGradient(
      colors: [
         Color.fromARGB(255, 15, 77, 24), // اللون الأساسي
        Color.fromARGB(255, 3, 50, 14), // أخضر غامق
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Column(
      children: [
        // الشعار
         SizedBox(
          width:
              MediaQuery.of(context).size.width * 1,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Image.asset(AppImages.roundedLogo,
                fit: BoxFit.fitWidth), 
          ),
        ),
        const SizedBox(height: 16), 

        
        ShaderMask(
          shaderCallback: (bounds) {
            return textGradient.createShader(bounds);
          },
          child: Text(
            'مرحبا بكم في',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24, 
                  color:
                      Colors.white, 
                ),
          ),
        ),
        const SizedBox(height: 8),

        // // النص الثاني
        // ShaderMask(
        //   shaderCallback: (bounds) {
        //     return textGradient.createShader(bounds);
        //   },
        //   child: Text(
        //     'بهارات الياسيني',
        //     style: Theme.of(context).textTheme.titleLarge?.copyWith(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 28, 
        //           color:
        //               Colors.white, 
        //         ),
        //   ),
        // ),
      ],
    );
  }
}
