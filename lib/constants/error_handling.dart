import 'dart:convert';

import 'package:easy_islington/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  //Navigator.of(context).pop();
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      Navigator.of(context).pop();
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      Navigator.of(context).pop();
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}
