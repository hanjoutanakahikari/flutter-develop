void printInteger(int aNumber){
  print('へえ、＄つけるだけで変数として認識できちゃうんだあ→$aNumber');
}

//List<int> list1 = [];　この形じゃないとエラーになるんですよね...
void printList(int lNumber){
  List<int> list1 = [];
  list1.add(lNumber);
  print(list1);
}

//引数にrequired付けると絶対になる
void printRequired({required String arg1, required int arg2 }){
  print("$arg1, $arg2");
}

//よくわからん
void hello() => print('Hello');
void func(f) => f();

class GettoSet{
  int _data = 0;
  int get data => _data; //getter
  set data(int data){this._data = data;}//setter
}

void main(){
  var number = 25;
  printInteger(number);
  printList(number);
  printRequired(arg1: "強制的", arg2: 3);
  //helloが出る
  func(hello);

  //get/set
  GettoSet gs = GettoSet();
  gs.data = 10;
  print(gs.data);

}