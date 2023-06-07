import 'package:flutter/material.dart';
import 'package:my_comment/constants/color_constants.dart';

class DecoratedTextField extends StatefulWidget {
  const DecoratedTextField(
      {Key? key,
      required this.hintField,
      required this.isObscured,
      required this.textFieldController,
      this.type})
      : super(key: key);

  final TextEditingController textFieldController;

  final String hintField;
  final bool isObscured;
  final TextInputType? type;

  @override
  State<DecoratedTextField> createState() => _DecoratedTextFieldState();
}

class _DecoratedTextFieldState extends State<DecoratedTextField> {
  bool checkIfClicked = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        keyboardType: widget.type,
        textInputAction: TextInputAction.next,
        controller: widget.textFieldController,
        obscureText: widget.isObscured && checkIfClicked == false,
        decoration: InputDecoration(
          isDense: true,
          label: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(widget.hintField),
          ),
          filled: true,
          contentPadding: const EdgeInsets.all(15),
          border: const OutlineInputBorder(),
          fillColor: ColorConstants.pureWhite,
          suffixIcon: widget.isObscured == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      checkIfClicked = !checkIfClicked;
                    });
                  },
                  icon: checkIfClicked == true
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off))
              : null,
        ),
      ),
    );
  }
}
