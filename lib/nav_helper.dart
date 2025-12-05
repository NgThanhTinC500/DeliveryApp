import 'package:flutter/material.dart';

// This allows you to call context.push() directly!
extension NavigationHelper on BuildContext {
  
  // Go to a new screen
  void push(Widget screen) {
    Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  // Go back
  void pop() {
    Navigator.pop(this);
  }

  // Go to a screen and remove all previous screens (e.g., Logout or Finish Order)
  void pushAndRemoveUntil(Widget screen) {
    Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }
}