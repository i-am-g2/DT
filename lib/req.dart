import 'dart:convert';
import 'package:http/http.dart' as http;

const URL = 'http://172.30.139.25:9090/ssssportal1/fetchUserQuotaPM.do';
const cookieURL = "http://172.30.139.25:9090/ssssportal1/manualRedirection.do";

class DataBalance {
  String today;
  String total;
  bool valid;

  DataBalance({this.today, this.total, this.valid});
}

String jsessionId(String cookie) {
  return "NULL";
}

Future<DataBalance> fetchData() async {
  var rsp = await http.get(cookieURL, headers: {
    "User-Agent":
        "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:82.0) Gecko/20100101 Firefox/82.0",
    "Connection": "keep-alive",
    "Cache-Control": "no-cache"
  }).timeout(
    Duration(seconds: 5),
    onTimeout: () {
      print("Request Timeout");
      return null;
    },
  );
  if (rsp == null) {
    return new DataBalance(today: "-1", total: "-1", valid: false);
  }

  var cookie = rsp.headers["set-cookie"];
  cookie = cookie.split(';')[0];
  print(cookie);

  var body = {
    "location": "KOLK",
    "actionName": "manual",
    "_search": "false",
    "nd": "1588531706139",
    "rows": "4",
    "page": "1",
    "sidx": "",
    "sord": "asc"
  };

  var header = {
    "Host": "172.30.139.25:9090",
    "User-Agent":
        "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:75.0) Gecko/20100101 Firefox/75.0",
    "Accept":
        "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
    "Accept-Language": "en-US,en;q=0.5",
    "Accept-Encoding": "gzip, deflate",
    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
    "Content-Length": "91",
    "Connection": "keep-alive",
    "Cookie": cookie,
    "Upgrade-Insecure-Requests": "1",
    "Pragma": "no-cache",
    "Cache-Control": "no-cache",
    "Referer": "http://172.30.139.25:9090/ssssportal1/manualRedirection.do"
  };

  var resp = await http.post(URL, body: body, headers: header).timeout(
    Duration(seconds: 5),
    onTimeout: () {
      print("TimedOut");
      return null;
    },
  );
  print(resp);
  if (resp == null) {
    print("Error : Timeout");
    return new DataBalance(today: "-1", total: "-1", valid: false);
  }
  var jsonResp = jsonDecode(resp.body);
  print("Decoding");
  print(resp.body);
  if (resp.statusCode == 404 || jsonResp["resultCode"] == "404") {
    print("Error : 404 or SessionInvalid");
    return new DataBalance(today: "-1", total: "-1", valid: false);
  } else {
    var todayUsage = jsonResp['rows'][0]['dailyUsedOctets'];
    var totalUsage = jsonResp['rows'][0]['totalOctets'];
    print(todayUsage);
    print(totalUsage);
    return new DataBalance(today: todayUsage, total: totalUsage, valid: true);
  }
}
