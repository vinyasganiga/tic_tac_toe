import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;
  List<String> displayElement = ['', '', '', '', '', '', '', '', ''];
  int oScore = 0;
  int xScore = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0f172a),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Tic Tac Toe",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
        centerTitle: true,
      ),

      body: Column(
        children: [
          _buildScoreBoard(),

          SizedBox(height: 10),

          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: 9,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, crossAxisSpacing: 12, mainAxisSpacing: 12),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _tapped(index),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [Color(0xff1e293b), Color(0xff334155)],
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6,
                              offset: Offset(2, 3))
                        ],
                      ),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 300),
                          style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: displayElement[index] == "X"
                                ? Colors.redAccent
                                : Colors.lightGreenAccent,
                          ),
                          child: Text(displayElement[index]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 15),

          ElevatedButton.icon(
            icon: Icon(Icons.refresh, color: Colors.white),
            label: Text(
              "Reset Scores",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            onPressed: _clearScoreBoard,
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildScoreBoard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _playerCard("Player X", xScore, Colors.redAccent),
          _playerCard("Player O", oScore, Colors.lightGreenAccent),
        ],
      ),
    );
  }

  Widget _playerCard(String title, int score, Color color) {
    return Container(
      width: 150,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          gradient:
          LinearGradient(colors: [Color(0xff1e293b), Color(0xff334155)]),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black54, blurRadius: 6, offset: Offset(2, 3))
          ]),
      child: Column(
        children: [
          Text(title,
              style: TextStyle(
                  color: color,
                  fontSize: 22,
                  fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text(score.toString(),
              style: TextStyle(color: Colors.white, fontSize: 28))
        ],
      ),
    );
  }

  // ----------------- GAME LOGIC (same as your code) -----------------

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayElement[index] == '') {
        displayElement[index] = 'O';
        filledBoxes++;
      } else if (!oTurn && displayElement[index] == '') {
        displayElement[index] = 'X';
        filledBoxes++;
      }

      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // ROWS
    if (displayElement[0] == displayElement[1] &&
        displayElement[0] == displayElement[2] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[3] == displayElement[4] &&
        displayElement[3] == displayElement[5] &&
        displayElement[3] != '') {
      _showWinDialog(displayElement[3]);
    }
    if (displayElement[6] == displayElement[7] &&
        displayElement[6] == displayElement[8] &&
        displayElement[6] != '') {
      _showWinDialog(displayElement[6]);
    }

    // COLUMNS
    if (displayElement[0] == displayElement[3] &&
        displayElement[0] == displayElement[6] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[1] == displayElement[4] &&
        displayElement[1] == displayElement[7] &&
        displayElement[1] != '') {
      _showWinDialog(displayElement[1]);
    }
    if (displayElement[2] == displayElement[5] &&
        displayElement[2] == displayElement[8] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    }

    // DIAGONALS
    if (displayElement[0] == displayElement[4] &&
        displayElement[0] == displayElement[8] &&
        displayElement[0] != '') {
      _showWinDialog(displayElement[0]);
    }
    if (displayElement[2] == displayElement[4] &&
        displayElement[2] == displayElement[6] &&
        displayElement[2] != '') {
      _showWinDialog(displayElement[2]);
    }

    // DRAW
    if (filledBoxes == 9) {
      _showDrawDialog();
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text("$winner Wins 🎉"),
          actions: [
            TextButton(
              onPressed: () {
                _clearBoard();
                Navigator.pop(context);
              },
              child: Text("Play Again"),
            )
          ],
        ));

    if (winner == 'O') {
      oScore++;
    } else {
      xScore++;
    }
  }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Draw!"),
          actions: [
            TextButton(
                onPressed: () {
                  _clearBoard();
                  Navigator.pop(context);
                },
                child: Text("Play Again"))
          ],
        ));
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayElement[i] = '';
      }
      filledBoxes = 0;
    });
  }

  void _clearScoreBoard() {
    setState(() {
      xScore = 0;
      oScore = 0;
      displayElement = ['', '', '', '', '', '', '', '', ''];
      filledBoxes = 0;
    });
  }
}
