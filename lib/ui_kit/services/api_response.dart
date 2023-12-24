part of '../local_pub.dart';

class ApiResponse<T> {
  final String status;
  final String? message;
  final int? code;
  final T? data;

  ApiResponse({required this.status, this.message, this.code, this.data});
}
