import 'dart:convert';
import 'package:frosh_link/model/jobs.dart';
import 'package:http/http.dart' as http;
import 'package:frosh_link/model/mainJob.dart';

class JobApi {
  static Future<List<Jobs>> getJobs(String query) async {
    final url = Uri.parse('https://remotive.io/api/remote-jobs');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<Jobs> temp = [];
      // job.fromJson(jsonDecode(response.body));
      final books = job.fromJson(jsonDecode(response.body)).jobs;
      books.forEach((element) {
        
        temp.add(Jobs.fromJson(element));
      });
      //  return temp;
      return temp.where((element) {
        final titleLower = element.title.toLowerCase();
        final searchLower = query.toLowerCase();
        
        final categoryLower = element.category.toLowerCase();
        final jobTypeLower = element.jobtype.toLowerCase();
       

        return titleLower.contains(searchLower) || categoryLower.contains(searchLower) || jobTypeLower.contains(searchLower);
      }).toList();
    } else {
      throw Exception();
    }
  }
}
