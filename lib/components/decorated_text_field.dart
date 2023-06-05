import 'package:flutter/material.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintField,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        TextField(
          keyboardType: widget.type,
          textInputAction: TextInputAction.next,
          controller: widget.textFieldController,
          obscureText: widget.isObscured && checkIfClicked == false,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            suffixIcon: widget.isObscured == true
                ? IconButton(
                    //
                    // Metnin gizliliğini değiştirir.
                    //
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
      ],
    );
  }
}
