abstract class BottomNavBarEvent {
  int position;
  BottomNavBarEvent({required this.position});
}

class ChangeBottomNavBarPosition extends BottomNavBarEvent {
  ChangeBottomNavBarPosition({required super.position});
}
