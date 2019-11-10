import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:instagram_clone/screens/addpost.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'mainscreen.dart';
import 'addpost.dart';
import 'activity.dart';
import 'PorfileScreen.dart';
class searchscreen extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
      InstagramBloc bloc = Provider.of<InstagramBloc>(context);
       List<Post> p = bloc.timeline;
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(decoration: InputDecoration(
          icon: Icon(FontAwesomeIcons.search),
    labelText: 'Search'
  ),),
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFFAFAFA),
        
      ),
      body: GridView.count(
  // Create a grid with 2 columns. If you change the scrollDirection to
  // horizontal, this produces 2 rows.
  crossAxisCount: 3,
  // Generate 100 widgets that display their index in the List.
  children: List.generate(bloc.timeline.length, (index) {
    return Center(
      child: Image.network(p[index].image_url),
    );
  }
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
                onPressed: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainScreen()),
                  );
                },
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