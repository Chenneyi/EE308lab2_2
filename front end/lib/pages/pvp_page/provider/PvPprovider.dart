import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PvPData with ChangeNotifier {
  int turn = 0;
  int back = 0;
  int remember = 0;
  int uppoint = 0;
  int downpoint = 0;
  int randomNum = 0;
  List<int> updata = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> downdata = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  int get getNum => randomNum;
  List<int> get upMat => updata;
  List<int> get downMat => downdata;
  void reset() {
    turn = 0;
    remember = 0;
    uppoint = 0;
    downpoint = 0;
    randomNum = 0;
    updata = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    downdata = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    notifyListeners();
  }

  void getnum() {
    remember = turn;
    randomNum = Random().nextInt(6) + 1;
    notifyListeners();
    print(randomNum);
  }

  int updatePoint(List<int> mat) {
    int point = 0;
    for (int i = 0; i < 3; i++) {
      List<int> count = [mat[i], mat[3 + i], mat[6 + i]];
      count.sort();
      if (count[0] == count[1]) {
        //all of the three
        if (count[1] == count[2]) {
          point += 9 * count[0];
        }
        //the first two equals
        else {
          point += (4 * count[0] + count[2]);
        }
      }
      //the last two
      else if (count[1] == count[2]) {
        point += (count[0] + 4 * count[1]);
      }
      //just three nums
      else {
        point += (count[0] + count[1] + count[2]);
      }
    }
    return point;
  }

  void updatemat(int sign, List<int> newmat, index, context) {
    if (sign == 0) {
      updata = newmat;
    } else {
      downdata = newmat;
    }
    check(sign, index);

    downpoint = updatePoint(downdata);
    uppoint = updatePoint(updata);
    turn == 0 ? turn = 1 : turn = 0;
    check_terminal(context);
    print(turn);
    notifyListeners();
  }

  void check(int sign, int position) {
    if (sign == 0) {
      for (int i = position % 3; i < 9; i += 3) {
        if (downMat[i] == upMat[position]) {
          downMat[i] = 0;
        }
      }
    } else {
      for (int i = position % 3; i < 9; i += 3) {
        if (upMat[i] == downMat[position]) {
          upMat[i] = 0;
        }
      }
    }
  }

  void check_terminal(context) {
    int check1 = 0;
    int check2 = 0;
    for (int i = 0; i < 9; i++) {
      if (updata[i] == 0) check1 = 1;
      if (updata[i] == 0) check2 = 1;
    }
    if (check1 == 0 || check2 == 0) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            String result;
            print(uppoint + downpoint);
            if (uppoint > downpoint) {
              result = "player1 win";
            }
            if (uppoint == downpoint) {
              result = "game over";
            }
            if (uppoint < downpoint) {
              result = "player2 win";
            }
            return CupertinoAlertDialog(
              title: Text('hint'),
              content: Text(result),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('One more round'),
                  onPressed: () {
                    Navigator.of(context).pop('cancel');
                  },
                ),
                CupertinoDialogAction(
                  child: Text('leave'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    back = 1;
                  },
                ),
              ],
            );
          });
      Future.delayed(Duration(milliseconds: 2000), () {
        reset();
      });
    }
  }
}
