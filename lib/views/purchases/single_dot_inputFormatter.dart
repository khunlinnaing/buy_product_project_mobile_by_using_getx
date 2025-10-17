import 'package:flutter/services.dart';

class SingleDotInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.contains('.') &&
        newValue.text.indexOf('.') != newValue.text.lastIndexOf('.')) {
      // Error sound/playback ပြဖို့ optional
      SystemSound.play(SystemSoundType.alert);
      return oldValue;
    }
    final regex = RegExp(r'^[0-9.]*$');
    if (!regex.hasMatch(newValue.text)) {
      return oldValue;
    }

    return newValue;
  }
}
