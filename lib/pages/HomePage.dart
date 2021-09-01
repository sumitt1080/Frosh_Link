import 'dart:async';
import 'package:flutter_html/flutter_html.dart';
import 'package:frosh_link/api/apiCall.dart';
import 'package:flutter/material.dart';
import 'package:frosh_link/model/jobs.dart';
import 'package:frosh_link/pages/infoPage.dart';
import 'package:frosh_link/widgets/searchwidgets.dart';
import 'detailsPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _homepage createState() => _homepage();
}

class _homepage extends State<HomePage> {
  String query = '';
  List<Jobs> jobs = [];
  Timer? debouncer;
  @override
  void initState() {
    super.initState();
    init();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future init() async {
    final books = await JobApi.getJobs(query);

    setState(() => this.jobs = books);
  }

  sort(int flag) {
    if (flag == 1) {
      setState(() {
        jobs.sort((job1, job2) => job2.date.compareTo(job1.date));
      });
    } else {
      setState(() {
        jobs.sort((job1, job2) => job1.date.compareTo(job2.date));
      });
    }
  }

  Future searchJob(String query) async => debounce(() async {
        final books = await JobApi.getJobs(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.jobs = books;
        });
      });

  void handleClick() {
    // switch (value) {
    //   case 'Sort':
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 300,
              color: Color(0xFF99badd),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Sort with Publication Date:',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      child: Text(
                        'Latest Jobs First',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () => sort(1),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      child: Text(
                        'Old Jobs First',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                      onPressed: () => sort(2),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                      child: const Text(
                        'Close',
                        style: TextStyle(fontSize: 15.0, color: Colors.red),
                      ),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              ),
            );
          },
        );
    //     break;
      
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF00bfff),
      appBar: AppBar(
        title: Text('Frosh Link API result'),
        actions: <Widget>[
          // PopupMenuButton<String>(
          //   onSelected: handleClick,
          //   itemBuilder: (BuildContext context) {
          //     return {'Sort'}.map((String choice) {
          //       return PopupMenuItem<String>(
          //         value: choice,
          //         child: Text(choice),
          //       );
          //     }).toList();
          //   },
          // ),
          GestureDetector(
            child: Icon(Icons.info_outline),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
                return Info();
              }));
            },
          ),
          SizedBox(width: 20.0,),
          GestureDetector(
            child: Icon(Icons.sort_rounded),
            onTap: () => handleClick(),
          ),
           SizedBox(width: 15.0,),
        ],
      ),
      body: Column(
        children: [
          SearchWidget(text: query, onChanged: searchJob, hintText: 'Search'),
          Expanded(
            child: ListView.builder(
                itemCount: this.jobs.length,
                itemBuilder: (context, index) {
                  return cards(this.jobs[index]);
                }),
          ),
        ],
      ),
    );
  }

  Widget cards(Jobs temp) {
    String title = temp.title;
    String category = temp.category;
    String jobType = temp.jobtype;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detailspage(jobDetails: temp)));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.12,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(left: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                '$title',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'Category : $category',
                style: TextStyle(fontSize: 14),
              ),
              Text(
                'Category : $jobType',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
