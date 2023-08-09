import 'dart:convert';
import 'dart:developer';
import 'package:devstash/constants.dart';
import 'package:devstash/models/request/educationRequest.dart';
import 'package:devstash/models/request/skillRequest.dart';
import 'package:devstash/models/response/education.dart';
import 'package:devstash/models/response/skillResponse.dart';
import 'package:http/http.dart' as http;

class SkillServices {
  Future<dynamic> updateskill(SkillRequest skill, String? authToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.skillsEndpoint);
      var headers = {
        'Authorization': authToken ?? '',
      };
      var response = await http.put(url,
          headers: headers, body: jsonEncode(skill.toJson()));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<SkillResponse?> getskill(String? authToken) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.skillsEndpoint);
      var headers = {
        'Authorization': authToken ?? '',
      };
      var response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        return skillFromJson(response.body);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future<dynamic> deleteskill(String? authToken, SkillRequest skill) async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.skillsEndpoint);
      var headers = {
        'Authorization': authToken ?? '',
      };
      var response = await http.delete(url,
          headers: headers, body: jsonEncode(skill.toJson()));
      if (response.statusCode == 200) {
        return "deleted";
      }
    } catch (e) {
      log(e.toString());
    }
  }

  SkillResponse skillFromJson(String jsonData) {
    final json = jsonDecode(jsonData)["skills"];

    List<String> skills = [];
    String id = json['ID'];
    String userid = json['UserID'];
    for (var i in json["Skills"]) {
      skills.add(i);
    }
    SkillResponse res = SkillResponse(id: id, userid: userid, skills: skills);
    return res;
  }
}
