import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/screens/PorfileScreen.dart';
import 'package:instagram_clone/screens/searchscreen.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'addpost.dart';
import 'PorfileScreen.dart';


class activityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Activity",
      style: TextStyle(color: Colors.black),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Color(0xFFFAFAFA),
      ),

      body: Center(
        child: ListView.builder(
          itemCount: bloc.timeline.length,
        itemBuilder: (_, i) {
          Post p = bloc.timeline[i];
          return Column(
            children: <Widget>[
             new Container(
                    child: p.profile_image_url != null
                    ? CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(p.profile_image_url),
                    )
                    : CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage("https://i1.wp.com/frfars.org/wp-content/uploads/2018/12/place-holder-for-profile-picture-4.png?ssl=1"),
                    )
                  ),

          ],
          );
        },
        ),
      ),
            bottomNavigationBar: BottomAppBar(
        color: Color(0xFFFAFAFA),
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: IconButton(
                icon: Icon(Icons.home),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {},
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: IconButton(
                icon: Icon(Icons.search),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => searchscreen()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.plusSquare),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FilePickerDemo()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.heart),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => activityScreen()),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              child: IconButton(
                icon: Icon(FontAwesomeIcons.user),
                iconSize: 40,
                color: Colors.black,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen(bloc.myAccount)),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}