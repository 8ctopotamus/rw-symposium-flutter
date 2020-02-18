import 'package:flutter/material.dart';

const TextStyle headingStyle = TextStyle(
  fontSize: 28.0,
);

class AboutScreen extends StatelessWidget {
  static const String id = 'about_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'About The Real Wealth® Advisor Symposium',
                style: headingStyle,
              ),
              Text('Here at Real Wealth®, our core mission is to educate, inspire, and motivate Americans to make smart choices with their money. We believe that wealth is not about money; rather, it’s about leading a fulfilling life. We believe it’s important for Americans to work with a professional who understands both the industry and their personal situation, who can help them implement a strategy that makes sense for them. Finances can be emotional, complex, and overwhelming without the coaching of a professional who can make them aware of opportunities and strategies that will help them avoid financial hardship, reach their financial goals, and ultimately live the life they want to live. The mission of this event is to educate, inspire and motivate you, America’s professional advisors, to be the best you can be for your clients and community. We aim to arm you with information, ideas and strategies that will help build your business and ultimately assist you in serving your clients like never before.'),
              SizedBox( height: 25.0 ,),
              Text(
                'Fun compliance notes - your favorite! 🙃',
                style: headingStyle,
              ),
              Text('By using this app, you grant permission to Real Wealth® to use your comments and any pictures shared within the app for marketing purposes. This helps us further our mission by inspiring more advisors to implement our services.'),
              SizedBox( height: 10.0 ,),
              Text('By attending this event, you understand that photography, video and audio recording will occur. You consent to interview(s), photography, audio recording, video recording and its/their release, publication, exhibition, or reproduction to be used for news, web casts, promotional purposes, telecasts, advertising, inclusion on websites, social media, or any other purpose by Real Wealth® and its affiliates and representatives. Images, photos and/or videos may be used to promote similar Real Wealth® events in the future, highlight the event and exhibit the capabilities of Real Wealth®. You release Real Wealth®, its officers and employees, and each and all persons involved from any liability connected with the taking, recording, digitizing, or publication and use of interviews, photographs, computer images, video and/or or sound recordings.'),
              SizedBox( height: 10.0 ,),
              Text('By entering the event premises, you waive all rights you may have to any claims for payment or royalties in connection with any use, exhibition, streaming, web casting, televising, or other publication of these materials, regardless of the purpose or sponsoring of such use, exhibiting, broadcasting, web casting, or other publication irrespective of whether a fee for admission or sponsorship is charged. You also waive any right to inspect or approve any photo, video, or audio recording taken by Real Wealth® or the person or entity designated to do so by Real Wealth®. You have been fully informed of your consent, waiver of liability, and release before entering the event.'),
              SizedBox( height: 10.0 ,),
              Text('Speakers and other partners mentioned or present at this event are central to the success of The Real Wealth® Advisor Symposium. Speakers and partners are not employees of Real Wealth® and Real Wealth® neither pre-reviews nor comments on the content of our speakers or partner sessions or exhibits. Speaker and Partner views and opinions are entirely their own and in no way reflect the views and opinions of Real Wealth®.'),
            ],
          ),
        ),
      ),
    );
  }
}