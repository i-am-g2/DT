import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
const cookieURL = "http://172.30.139.25:9090/ssssportal1/manualRedirection.do";
// const cookieURL = 'http://www.google.com';
// Host: 172.30.139.25:9090
// User-Agent: Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:82.0) Gecko/20100101 Firefox/82.0
// Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
// Accept-Language: en-US,en;q=0.5
// Accept-Encoding: gzip, deflate
// Connection: keep-alive
// Cookie: JSESSIONID=88A25C05BC053D1333A7DE8F08D8A010
// Upgrade-Insecure-Requests: 1
// Pragma: no-cache
// Cache-Control: no-cache
main() async {
  var rsp = await http.get(cookieURL, headers: {"User-Agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:82.0) Gecko/20100101 Firefox/82.0", "Connection":"keep-alive", "Cache-Control":"no-cache"});
  var cookie = rsp.headers["set-cookie"];
  cookie = cookie.split(';')[0];
  print(cookie);
}