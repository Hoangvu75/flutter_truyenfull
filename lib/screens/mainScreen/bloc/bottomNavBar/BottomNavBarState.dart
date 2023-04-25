class BottomNavBarState {
  int position;
  BottomNavBarState({required this.position});
}

class BottomNavBarInitialState extends BottomNavBarState {
  BottomNavBarInitialState(): super(position: 0);
}

