# MD14: The icon design specification for Nana series open-source projects

[简体中文](ReadMe.zh-CN.md)

- Design SVG vector icons based on 96x96 with all important edges aligned to the
  6px grid
- Provide square PNG icons based on SVG vector icons with the following widths:
  16px, 20px, 24px, 30px, 32px, 36px, 40px, 48px, 60px, 64px, 72px, 80px, 90px,
  96px, 108px, 120px, 128px, 144px, 160px, 192px, 216px, 256px, 288px, 320px,
  384px, 512px, 768px, 1024px
  - Basis: [IconSizes.xlsx](IconSizes.xlsx)
- The square PNG icons may need to be fine-tuned where appropriate
- Provide SVG vector icons and the corresponding widths square PNG icons
- All icons except the file association icons need to be provided in high
  contrast dark and light versions
- [Recommended] Windows ICO file requirements
  - Application and Self Extracting Executable icons only
  - The following widths are required: 16px, 20px, 24px, 32px, 40px, 48px, 64px,
    256px
  - 256px icons need to be compressed, other sizes are not allowed to be 
    compressed to ensure compatibility with older Windows versions

## Naming Conventions

- Application Icons
  - SVG Vector Icons
    - [Project]/Standard/Standard.svg
    - [Project]Preview/Standard/Standard.svg
    - [Project]/ContrastBlack/ContrastBlack.svg
    - [Project]Preview/ContrastBlack/ContrastBlack.svg
    - [Project]/ContrastWhite/ContrastWhite.svg
    - [Project]Preview/ContrastWhite/ContrastWhite.svg
  - Square PNG Icons
    - [Project]/Standard/Standard_[Width].png
    - [Project]Preview/Standard/Standard_[Width].png
    - [Project]/ContrastBlack/ContrastBlack_[Width].png
    - [Project]Preview/ContrastBlack/ContrastBlack_[Width].png
    - [Project]/ContrastWhite/ContrastWhite_[Width].png
    - [Project]Preview/ContrastWhite/ContrastWhite_[Width].png
  - ICO Icons
    - [Project]/Standard/Standard.ico
    - [Project]Preview/Standard/Standard.ico
- Non-application Icons
  - SVG Vector Icons
    - [Project]/[Identifier]/[Identifier].svg
    - [Project]Preview/[Identifier]/[Identifier].svg
  - Square PNG Icons
    - [Project]/[Identifier]/[Identifier]_[Width].png
    - [Project]Preview/[Identifier]/[Identifier]_[Width].png
  - ICO Icons
    - [Project]/[Identifier]/[Identifier].ico
    - [Project]Preview/[Identifier]/[Identifier].ico

## List of non-application icons identifiers

- NanaZip
  - File Association: ArchiveFile
  - Self Extracting Executable: SelfExtractingExecutable
- NanaBox
  - File Association: ConfigurationFile
- NanaGet
  - File Association: MetadataFile

## Reference Tools

- https://www.figma.com/community/plugin/1000211110592209830/Icon-Sizes
- https://www.figma.com/community/plugin/875501505522624941/Icon-Scaling-Tool
- https://www.figma.com/community/plugin/742318143106037364/icns%2Fico-Generator
- https://www.figma.com/community/plugin/1043591651911818218/Icon-Pixel-Preview

## Thanks

- Belleve, https://github.com/be5invis
- Denissssse, https://github.com/Shomnipotence
