import 'package:flutter_quill/flutter_quill.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sama/utils/formatUtils.dart';

QuillController handleDescription(
    String description, bool isReadOnly, bool shouldLimit) {
  try {
    // Try to parse the string as JSON
    final parsedJson = json.decode(description);

    // If parsing is successful, assume it's already in Quill JSON format
    return QuillController(
      readOnly: isReadOnly,
      document: Document.fromJson(parsedJson),
      selection: const TextSelection.collapsed(offset: 0),
    );
  } catch (e) {
    // If parsing fails, treat it as plain text and convert it to Quill format
    final plainText = shouldLimit ? limitString(description, 250) : description;
    final doc = Document()..insert(0, plainText);

    return QuillController(
      readOnly: isReadOnly,
      document: doc,
      selection: const TextSelection.collapsed(offset: 0),
    );
  }
}
