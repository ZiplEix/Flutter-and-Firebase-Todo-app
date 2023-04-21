import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FormInputWidget extends StatelessWidget {
  const FormInputWidget({
    super.key,
    required this.labelText,
    required this.controller,
    required this.obscureText,
  });

  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            fontSize: 17,
            color: Colors.white,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1.5,
              color: Colors.amber,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class AuthButtonWidget extends StatelessWidget {
  const AuthButtonWidget({
    super.key,
    required this.logoPath,
    required this.textContent,
    required this.size,
    required this.action,
  });

  final String logoPath;
  final String textContent;
  final double size;
  final Function action;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => action(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
          color: Colors.black,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: const BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                logoPath,
                height: size,
                width: size,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                textContent,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
