# MD14: Nana 系列开源项目图标设计规范

[English](ReadMe.md)

- 以 96x96 为基准设计 SVG 矢量图标，并且让重要边缘全部对齐到 6px 网格
- 基于 SVG 图标提供以下宽度的正方形 PNG 图标: 16px, 20px, 24px, 30px, 32px,
  36px, 40px, 48px, 60px, 64px, 72px, 80px, 90px, 96px, 108px, 120px, 128px,
  144px, 160px, 192px, 216px, 256px, 288px, 320px, 384px, 512px, 768px, 1024px
  - 依据: [IconSizes.xlsx](IconSizes.xlsx)
- png 图标在可能需酌情进行微调
- 提供 SVG 矢量图标和 PNG 对应宽度的正方形图标
- 除文件关联图标外，其他图标需要提供高对比度明暗版本
- [建议] Windows ICO 文件要求
  - 仅限应用程序和自解压图标
  - 需要包含以下宽度: 16px, 20px, 24px, 32px, 40px, 48px, 64px, 256px
  - 256px 图标需要勾选压缩，其他尺寸不允许压缩以保证旧版 Windows 兼容性

## 命名规范

- 应用程序图标
  - SVG 矢量图标
    - [项目名]/Standard/Standard.svg
      [项目名]Preview/Standard/Standard.svg
    - [项目名]/ContrastBlack/ContrastBlack.svg
      [项目名]Preview/ContrastBlack/ContrastBlack.svg
    - [项目名]/ContrastWhite/ContrastWhite.svg
      [项目名]Preview/ContrastWhite/ContrastWhite.svg
  - 正方形 PNG 图标
    - [项目名]/Standard/Standard_[宽度数字].png
      [项目名]Preview/Standard/Standard_[宽度数字].png
    - [项目名]/ContrastBlack/ContrastBlack_[宽度数字].png
      [项目名]Preview/ContrastBlack/ContrastBlack_[宽度数字].png
    - [项目名]/ContrastWhite/ContrastWhite_[宽度数字].png
      [项目名]Preview/ContrastWhite/ContrastWhite_[宽度数字].png
  - ICO 图标
    - [项目名]/Standard/Standard.ico
      [项目名]Preview/Standard/Standard.ico
- 非应用程序图标
  - SVG 矢量图标
    - [项目名]/[图标标识名]/[图标标识名].svg
    - [项目名]Preview/[图标标识名]/[图标标识名].svg
  - 正方形 PNG 图标
    - [项目名]/[图标标识名]/[图标标识名]_[宽度数字].png
    - [项目名]Preview/[图标标识名]/[图标标识名]_[宽度数字].png
  - ICO 图标
    - [项目名]/[图标标识名]/[图标标识名].ico
    - [项目名]Preview/[图标标识名]/[图标标识名].ico

## 文件关联图标标识名列表

- NanaZip
  - 文件关联: ArchiveFile
  - 自解压: SelfExtractingExecutable
- NanaBox
  - 文件关联: ConfigurationFile
- NanaGet
  - 文件关联: MetadataFile

## 参考工具

- https://www.figma.com/community/plugin/1000211110592209830/Icon-Sizes
- https://www.figma.com/community/plugin/875501505522624941/Icon-Scaling-Tool
- https://www.figma.com/community/plugin/742318143106037364/icns%2Fico-Generator
- https://www.figma.com/community/plugin/1043591651911818218/Icon-Pixel-Preview

## 感谢

- Belleve, https://github.com/be5invis
- Denissssse, https://github.com/Shomnipotence
