abstract class HeaderSelectorEvent {
  int position;
  HeaderSelectorEvent({required this.position});
}

class ChangeHeaderSelectorPosition extends HeaderSelectorEvent {
  ChangeHeaderSelectorPosition({required super.position});
}
