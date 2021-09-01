import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  Info({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Information'),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'How to Use?',
              style: TextStyle(color: Colors.black, fontSize: 35.0),
            ),
            Text(
              'Hi, this is an App made for the assessment purpose for the intern position in \"Frosh Link\". The App fetches Jobs information from a rest API and display it in form of cards. In this you can sort the Jobs based on their publication dates, and can filter according to your choices. For applying filter, search for your job type or category one by one and the filter will get applied accordingly. For ex. If you want to seach for \'Full time\' \'Sales\' jobs, if can first search for \'full_time\' then \'sales\' and you will see all Sales jobs of Full Time.',
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 20,
              style: TextStyle(fontSize: 22.0,),
            ),
          ],
        ),
      ),
    );
  }
}
