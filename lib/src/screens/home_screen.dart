import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bandnamessurvey_app/src/entities/DemoInfo.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<DemoInfo> _bandList = [
    DemoInfo(name: 'nombre demo 1', votes: 0),
    DemoInfo(name: 'nombre demo 2', votes: 0),
    DemoInfo(name: 'nombre demo 3', votes: 0),
    DemoInfo(name: 'nombre demo 4', votes: 0),
  ];

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('bandnames')
    //.where(field)
    .snapshots()
    .listen((data) => data.documents.forEach((item) => print(item['name'])));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        child: CustomScrollView(
          slivers: <Widget>[
            CupertinoSliverNavigationBar(
              largeTitle: Text('Band Names Survey'),
            ),
            SliverSafeArea(
              sliver: StreamBuilder<QuerySnapshot>(stream: Firestore.instance.collection('bandnames').snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(!snapshot.hasData) 
                    return SliverToBoxAdapter(
                      child: CupertinoActivityIndicator(),
                    );
                  else 
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index){
                          return _buildListItem(context, snapshot.data.documents[index]);
                        },
                        childCount: snapshot.data.documents.length, 
                      )
                    );
                },
              )
            )
          ],
        ),
      ),
    );
  }
  
  Widget _buildListItem(BuildContext context, DocumentSnapshot band){
    return ListTile(
      title: Text(band['name']),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text('${band['votes']}'),
          Icon(CupertinoIcons.right_chevron),
        ],
      ),
    );
  }
}