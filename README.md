# pill_tab_bar

A compact sliding pill-style tab bar widget for Flutter. The selected tab is
highlighted by a rounded **pill** that smoothly animates between positions —
a lightweight alternative to `TabBar` for segmented controls, mode switches,
and small navigation areas.

<p>
  <img src="screenshots/preview_dark.png" alt="Dark pill preview" width="320">
  <img src="screenshots/preview_light.png" alt="Light pill preview" width="320">
</p>

- Sliding pill indicator with customizable curve and duration
- Two or more tabs
- Optional leading icons
- Theme-aware defaults (colors fall back to the ambient `ColorScheme`)
- Fully customizable: pill color, foreground colors, background, text style,
  height, corner radius, shadow

## Install

```yaml
dependencies:
  pill_tab_bar: ^0.0.3
```

## Usage

```dart
import 'package:pill_tab_bar/pill_tab_bar.dart';

int _index = 0;

PillTabBar(
  tabs: const [
    PillTab(label: 'Body', icon: Icons.menu_book_outlined),
    PillTab(label: 'Sketch', icon: Icons.edit_outlined),
  ],
  index: _index,
  onChanged: (i) => setState(() => _index = i),
)
```

### Customizing colors

```dart
PillTabBar(
  tabs: const [
    PillTab(label: 'Day'),
    PillTab(label: 'Week'),
    PillTab(label: 'Month'),
  ],
  index: _index,
  onChanged: (i) => setState(() => _index = i),
  pillColor: Colors.indigo,
  selectedForeground: Colors.white,
  unselectedForeground: Colors.grey,
  backgroundColor: const Color(0x14000000),
  height: 36,
  textStyle: const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
  ),
)
```

## API

| Parameter | Type | Default |
|---|---|---|
| `tabs` | `List<PillTab>` | required |
| `index` | `int` | required |
| `onChanged` | `ValueChanged<int>` | required |
| `height` | `double` | `32` |
| `pillColor` | `Color?` | `ColorScheme.onSurface` |
| `selectedForeground` | `Color?` | `ColorScheme.surface` |
| `unselectedForeground` | `Color?` | derived from theme |
| `backgroundColor` | `Color?` | derived from theme |
| `textStyle` | `TextStyle?` | `labelMedium` w800 |
| `duration` | `Duration` | `240ms` |
| `curve` | `Curve` | `Curves.easeOutCubic` |
| `borderRadius` | `BorderRadius?` | fully rounded |
| `pillPadding` | `EdgeInsets` | `EdgeInsets.all(2)` |
| `iconSize` | `double` | `13` |
| `iconLabelSpacing` | `double` | `4` |
| `pillShadow` | `List<BoxShadow>?` | subtle |
| `backgroundShadow` | `List<BoxShadow>?` | none |

## License

MIT — see [LICENSE](LICENSE).
