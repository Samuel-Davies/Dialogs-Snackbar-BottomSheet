import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final snackBar = SnackBar(
    content: const Text('Successfully savad'),
    //backgroundColor: Colors.purple[700],
    duration: const Duration(seconds: 1),
    action: SnackBarAction(label: "Undo", onPressed: () {}),
  );

  String delete = 'No choice made';
  String location = 'None selected yet';

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text('Dialogs'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: const Text(
                'Save',
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(color: Colors.red, width: 2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                delete = 'You selected No';
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('No'),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                delete = 'You selected Yes';
                              });
                              Navigator.pop(context);
                            },
                            child: const Text('Yes'),
                          )
                        ],
                        title: const Text("Delete entry 12345?"),
                        content: const Text(
                            "Are you sure that you want to delete the entry?"),
                      );
                    });
              },
              child: const Text('Delete'),
            ),
            Text(delete),
            ElevatedButton(
              onPressed: () async {
                final String loc = await showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        title: const Text('choose your location'),
                        children: [
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'South Africa');
                            },
                            child: const Text('South Africa'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'America');
                            },
                            child: const Text('America'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              Navigator.pop(context, 'Brazil');
                            },
                            child: const Text('Brazil'),
                          ),
                        ],
                      );
                    });
                setState(() {
                  location = loc;
                });
              },
              child: const Text(
                'Choose Location',
              ),
            ),
            Text(location),
            ElevatedButton(
              onPressed: () {
                scaffoldKey.currentState?.showBottomSheet((context) {
                  return Container(
                    height: 130,
                    decoration: BoxDecoration(
                      color: Colors.orange[700],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            const Text(
                              'Are you sure you want to delete?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                            ButtonBar(
                              alignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'YES',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
              },
              child: const Text('Bottom Sheet'),
            ),
          ],
        ),
      ),
    );
  }
}
