import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class PvPOData with ChangeNotifier {
  String opponent = "receive";
  IOWebSocketChannel channel;
  int r = 1;
  int turn = 1;
  int remember = 0;
  int uppoint = 0;
  int downpoint = 0;
  int randomNum = 0;
  List<int> updata = [0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> downdata = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  int get getNum => randomNum;
  List<int> get upMat => updata;
  List<int> get downMat => downdata;

  void connect(String id, context) {
    channel = IOWebSocketChannel.connect('ws://120.77.79.99:8085/imserver/$id');
    channel.stream.listen((event) {
      print(event);
      if (r == 0) {
        Map<String, dynamic> data = jsonDecode(event.toString());

        updata = parse(data["mat2"]);
        downdata = parse(data["mat1"]);
        downpoint = updatePoint(updata);
        uppoint = updatePoint(downdata);
        print("\n\n\n\n\ndata received");
        turn = 1;
        check_terminal(context);
        notifyListeners();
      }
      if (r == 1) r = 0;
    });
  }

  void sendmsg(String msg) {
    Map<String, dynamic> data = {
      "toUserId": "$opponent",
      "mat1": "$updata",
      "mat2": "$downdata"
    };
    channel.sink.add(jsonEncode(data));
  }

  void reset(context) {
    turn = 0;
    remember = 0;
    uppoint = 0;
    downpoint = 0;
    randomNum = 0;
    updata = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    downdata = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    notifyListeners();
  }

  int getnum() {
    if (randomNum != 0) return randomNum;
    //generate a random number
    remember = turn;
    randomNum = Random().nextInt(6) + 1;
    notifyListeners();
    print("\n\n\n\n");
    print(randomNum);
    return randomNum;
  }

  int updatePoint(List<int> mat) {
    int point = 0;
    randomNum = 0;
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

  Future<void> updatemat(List<int> newmat, index, context) async {
    downdata = newmat;

    check(1, index);

    downpoint = updatePoint(downdata);
    uppoint = updatePoint(updata);
    turn = 0;

    check_terminal(context);

    sendmsg("msg");

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

  bool check_terminal(context) {
    int check1 = 0;
    int check2 = 0;
    for (int i = 0; i < 9; i++) {
      if (updata[i] == 0) check1 = 1;
      if (downdata[i] == 0) check2 = 1;
    }
    if (check1 == 0 || check2 == 0) {
      print("game over");

      showCupertinoDialog(
          context: context,
          builder: (context) {
            String result;
            // print(uppoint + downpoint);
            if (uppoint > downpoint) {
              result = "game over\nyou lose";
            }
            if (uppoint == downpoint) {
              result = "game over\nend in draw";
            }
            if (uppoint < downpoint) {
              result = "game over\nyou win";
            }
            return CupertinoAlertDialog(
              title: Text(result),
              content: Text("${uppoint}vs$downpoint"),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('One more round'),
                  onPressed: () {
                    turn = 1;
                    Navigator.of(context).pop('cancel');
                  },
                ),
                CupertinoDialogAction(
                  child: Text('leave'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
      Future.delayed(Duration(milliseconds: 1000), () {
        // print("延时1秒执行");
        reset(context);
        turn = 3;
      });
      return true;
    }
    return false;
  }
}

List<int> parse(String mat) {
  List<int> d = [];
  for (int i = 1; i < 26; i += 3) {
    print(mat[i]);
    d.add(int.parse(mat[i]));
  }
  return d;
}
