import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

BaseOptions options =
    BaseOptions(baseUrl: "", connectTimeout: 5000, receiveTimeout: 5000);
Dio dio = Dio(options);
