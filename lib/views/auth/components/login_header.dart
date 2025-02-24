import 'package:flutter/material.dart';
import '../../../core/constants/constants.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    const textGradient = LinearGradient(
      colors: [
        Color.fromARGB(255, 15, 77, 24),
        Color.fromARGB(255, 3, 50, 14),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.5, 
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(100), 
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3), 
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(AppImages.logo, fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
        ShaderMask(
          shaderCallback: (bounds) {
            return textGradient.createShader(bounds);
          },
          child: Text(
            ' مرحباً بكم في جزيرة العطار',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
