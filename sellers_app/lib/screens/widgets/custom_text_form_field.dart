import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String typefield;
  final TextEditingController controller;
  final String? Function(String? value)? valider;
  bool issecurse;
  final IconData icon;
  final bool enable;
  CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    this.valider,
    required this.issecurse,
    required this.icon,
    required this.enable,
    required this.typefield,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  IconData iconsuffix = Icons.visibility_off;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      width: 330.w,
      child: TextFormField(
        enabled: widget.enable,
        obscureText: widget.issecurse,
        controller: widget.controller,
        cursorColor: Theme.of(context).primaryColor,
        validator: widget.valider,
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide(),
          ),
          hintText: widget.hintText,
          suffixIcon: widget.typefield == "password"
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      widget.issecurse = !widget.issecurse;
                      iconsuffix = iconsuffix == Icons.visibility
                          ? Icons.visibility_off
                          : Icons.visibility;
                    });
                  },
                  icon: Icon(iconsuffix, color: Colors.purpleAccent))
              : const SizedBox(
                  width: 5,
                  height: 10,
                ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: Icon(
            widget.icon,
            color: Colors.purpleAccent,
          ),
          focusColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
