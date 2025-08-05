# MD24: The coding style for all my open-source projects

## Coding Philosophy

- Readability first.
- Prefer explicit than implicit.
- Use language features that are widely supported.
  - If you are writing C code, only use language features that are supported
    by Microsoft Visual C\+\+ (MSVC) unless really necessary.
  - If you are writing C\+\+11 code, only target for C\+\+11 or later unless
    you are targeting specific platforms that don't have compilers which support
    C\+\+11 or later. For language features introduced after C\+\+11, don't use
    them unless really necessary.
  - If you are writing C# code, only target for .NET Standard 2.0 unless you are
    targeting specific platforms that don't have .NET Standard 2.0 support.
- Use as less third-party libraries as possible. Prefer to use platform specific
  infrastructures and language standard libraries.
  - If you are targeting for Windows, here is the priority list of the platform
    specific infrastructures:
    - OneCore subset of Win32 API, but don't use API set direct forwarding
      unless the API you are using only exists in the API set.
    - Graphics, Media, and UI parts of Windows Runtime API, a.k.a. you can write
      Windows Runtime based applications but as OneCore subset of Win32 API as
      possible to have better performance.
  - If you are targeting for POSIX, here is the priority list of the platform
    specific infrastructures:
    - POSIX interfaces supported by both Linux and BSD.
    - For Linux, prefer to target for musl C library.

## General rules

- Use UTF-8 with BOM as the source code file encoding unless really necessary.
- Use CRLF as the line ending for source code files unless really necessary.
- Don't exceed 80 half-width characters per line unless really necessary for
  improving the readability.
- Use "PascalCase" for all identifiers unless really necessary.
- Use Allman style for braces if the language has braces unless the language
  don't support Allman style for braces.
- Only use hungarian notation in these scenarios:
  - For global variables, use "g_" prefix.
  - For member variables, use "m_" prefix.
- Avoid using abbreviations or acronyms unless they are widely understood.
- All comments should be in English unless really necessary, and you should only
  write comments for the interface which will be served to other projects.

## Specific rules for C and C\+\+

- Never use "using namespace" in C\+\+ code. Only use "using" with the type
  names that you are using in the current scope to avoid name conflicts as
  much as possible.
- If you are using C\+\+/WinRT, all C\+\+/WinRT types should be in the "winrt"
  namespace.
- Should use "nullptr" instead of "NULL" or "0" for null pointer if you are
  using C\+\+11 or later.
- Should not use initializer lists for better readability and maintainability
  because maybe the type definition sequence will change in the future.
- Use "::" prefix for functions in the global namespace to avoid name conflicts
  with other namespaces if you are using C\+\+.
- Use "this->" prefix for member functions and variables to avoid name conflicts
  if you are using C\+\+.
- Use SAL for C types in the function and method definitions.
- Use "Type& OutputParameter" and "Type const& InputParameter" style for C\+\+
  types in the function and method definitions.
- Never eliminate the definition of identifiers for unused parameters.
- The ");" should not in the separate line.

### Comment Style

Here is the format example for source code file header:

```cpp
/*
 * PROJECT:    NanaZip.Modern
 * FILE:       NanaZip.Modern.h
 * PURPOSE:    Definition for NanaZip Modern Experience
 *
 * LICENSE:    The MIT License
 *
 * MAINTAINER: MouriNaruto (Kenji.Mouri@outlook.com)
 */
```

Here is the format example for public identifiers:

```cpp
/**
 * @brief Flags for specifying the system-drawn backdrop material of a window,
 *        including behind the non-client area.
*/
typedef enum MILE_WINDOW_SYSTEM_BACKDROP_TYPE
{
    /**
     * @brief The default. Let the Desktop Window Manager (DWM) automatically
              decide the system-drawn backdrop material for this window.
    */
    MILE_WINDOW_SYSTEM_BACKDROP_TYPE_AUTO = 0,

    /**
     * @brief Don't draw any system backdrop.
    */
    MILE_WINDOW_SYSTEM_BACKDROP_TYPE_NONE = 1,

    /**
     * @brief Draw the backdrop material effect corresponding to a long-lived
     *        window.
    */
    MILE_WINDOW_SYSTEM_BACKDROP_TYPE_MICA = 2,

    /**
     * @brief Draw the backdrop material effect corresponding to a transient
     *        window.
    */
    MILE_WINDOW_SYSTEM_BACKDROP_TYPE_ACRYLIC = 3,

    /**
     * @brief Draw the backdrop material effect corresponding to a window with
     *        a tabbed title bar.
    */
    MILE_WINDOW_SYSTEM_BACKDROP_TYPE_MICA_ALT = 4

} MILE_WINDOW_SYSTEM_BACKDROP_TYPE, *PMILE_WINDOW_SYSTEM_BACKDROP_TYPE;

/**
 * @brief Retrieves the system-drawn backdrop material of a window, including
 *        behind the non-client area.
 * @param WindowHandle The handle to the window for which the attribute value
 *                     is to be set.
 * @param Value Flags for specifying the system-drawn backdrop material of a
 *              window, including behind the non-client area.
 * @return If the function succeeds, it returns S_OK. Otherwise, it returns an
 *         HRESULT error code.
*/
EXTERN_C HRESULT WINAPI MileGetWindowSystemBackdropTypeAttribute(
    _In_ HWND WindowHandle,
    _Out_ PMILE_WINDOW_SYSTEM_BACKDROP_TYPE Value);

/**
 * @brief Specifies the system-drawn backdrop material of a window, including
 *        behind the non-client area.
 * @param WindowHandle The handle to the window for which the attribute value
 *                     is to be set.
 * @param Value Flags for specifying the system-drawn backdrop material of a
 *              window, including behind the non-client area.
 * @return If the function succeeds, it returns S_OK. Otherwise, it returns an
 *         HRESULT error code.
*/
EXTERN_C HRESULT WINAPI MileSetWindowSystemBackdropTypeAttribute(
    _In_ HWND WindowHandle,
    _In_ MILE_WINDOW_SYSTEM_BACKDROP_TYPE Value);
```

### Examples

**Bad**

```cpp
namespace winrt
{
    using namespace Windows::Foundation;
    using namespace Windows::UI::Xaml;
}
```

**Good**

```cpp
namespace winrt
{
    using Windows::Foundation::IInspectable;
    using Windows::UI::Xaml::RoutedEventArgs;
}
```

**Bad**

```cpp
HWND m_WindowHandle{ nullptr };
```

**Good**

```cpp
HWND m_WindowHandle = nullptr;
```

**Bad**

```cpp
namespace winrt::NanaZip::Modern::factory_implementation
{
    struct StatusBarTemplate : StatusBarTemplateT<StatusBarTemplate, implementation::StatusBarTemplate>
    {
    };
}
```

**Good**

```cpp
namespace winrt::NanaZip::Modern::factory_implementation
{
    struct StatusBarTemplate : StatusBarTemplateT<
        StatusBarTemplate,
        implementation::StatusBarTemplate>
    {
    };
}
```

**Bad**

```cpp
namespace winrt::NanaZip::Modern::factory_implementation
{
    struct AddressBarTemplate : AddressBarTemplateT<AddressBarTemplate, implementation::AddressBarTemplate>
    { };
}
```

**Good**

```cpp
namespace winrt::NanaZip::Modern::factory_implementation
{
    struct AddressBarTemplate : AddressBarTemplateT<
        AddressBarTemplate,
        implementation::AddressBarTemplate>
    {
    };
}
```

**Bad**

```cpp
K7ModernShowInformationDialog(GetParent(), LangString(IDS_PROPERTIES).Ptr(), message.c_str());
```

**Good**

```cpp
::K7ModernShowInformationDialog(
    this->GetParent(),
    ::LangString(IDS_PROPERTIES).Ptr(),
    message.c_str());
```

**Bad**

```cpp
InformationPage(
    HWND WindowHandle,
    winrt::hstring WindowTitle,
    winrt::hstring WindowContent);

InformationPage::InformationPage(
    HWND WindowHandle,
    winrt::hstring WindowTitle,
    winrt::hstring WindowContent) :
    m_WindowHandle(WindowHandle),
    m_WindowTitle(WindowTitle),
    m_WindowContent(WindowContent)
{
}
```

**Good**

```cpp
InformationPage(
    _In_opt_ HWND WindowHandle,
    winrt::hstring const& WindowTitle,
    winrt::hstring const& WindowContent);

InformationPage::InformationPage(
    _In_opt_ HWND WindowHandle,
    winrt::hstring const& WindowTitle,  
    winrt::hstring const& WindowContent) :
    m_WindowHandle(WindowHandle),
    m_WindowTitle(WindowTitle),
    m_WindowContent(WindowContent)
{
}
```

**Bad**

```cpp
void BackgroundButtonClickedHandler(
    winrt::IInspectable const&,
    winrt::RoutedEventArgs const&
);

void ProgressPage::BackgroundButtonClickedHandler(
    winrt::IInspectable const&,
    winrt::RoutedEventArgs const& args)
{
    this->BackgroundButtonClicked(*this, args);
}
```

**Good**

```cpp
void BackgroundButtonClickedHandler(
    winrt::IInspectable const& sender,
    winrt::RoutedEventArgs const& e);

void ProgressPage::BackgroundButtonClickedHandler(
    winrt::IInspectable const& sender,
    winrt::RoutedEventArgs const& e)
{
    UNREFERENCED_PARAMETER(sender);
    this->BackgroundButtonClicked(*this, e);
}
```
