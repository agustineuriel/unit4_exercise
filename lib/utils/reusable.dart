import "package:flutter/material.dart";
import "package:unit4_exercise/utils/styles.dart";

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: heading,
    style: textBold,
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: accent,
      ),
      labelText: text,
      labelStyle: texts,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      fillColor: white,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:
              BorderSide(width: 1, style: BorderStyle.solid, color: accent)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container login(BuildContext context, String text, Function onPressed) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.width * 0.05,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () => onPressed(context), // Call the onPressed function here
      child: Text(
        text,
        style: textBold,
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return accent;
          }
          return white;
        }),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    ),
  );
}