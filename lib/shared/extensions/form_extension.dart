import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

extension FormExtension on GlobalKey<FormBuilderState> {
  dynamic getValue(String id) {
    return currentState?.fields[id]?.value;
  }

  Map<String, dynamic>? getFormValues() {
    return currentState?.fields
        .map((key, value) => MapEntry(key, value.transformedValue));
  }

  void setFormFieldValue(String id, dynamic value) {
    Future.delayed(
      Duration.zero,
      () {
        currentState?.fields[id]?.didChange(value);
      },
    );
  }

  void setFormValues(Map<String, dynamic>? values) {
    if (values == null) return;
    Future.delayed(
      Duration.zero,
      () {
        currentState?.patchValue(values);
      },
    );
  }

  void resetForm() {
    currentState?.reset();
  }
}
