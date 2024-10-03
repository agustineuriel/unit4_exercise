import "package:flutter/material.dart";
import "package:unit4_exercise/utils/styles.dart";

TextField reusableTextField(String text, IconData icon, bool isPasswordType,) {
  return TextField(
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: accent,
    style: texts,
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: accent,
      ),
      labelText: text,
      labelStyle: texts,
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: white,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}