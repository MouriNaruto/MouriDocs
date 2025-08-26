# MD24: The coding style for all my open-source projects

## Coding Philosophy

- Readability first.
- Prefer explicit than implicit.
- Use language features that are widely supported.
  - If you are writing C code, only use language features that are supported
    by Microsoft Visual C++ (MSVC) unless really necessary.
  - If you are writing C++11 code, only target for C++11 or later unless
    you are targeting specific platforms that don't have compilers which support
    C++11 or later. For language features introduced after C++11, don't use
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
  - For global variables, use `g_` prefix.
  - For member variables, use `m_` prefix.
- Avoid using abbreviations or acronyms unless they are widely understood.
- All comments should be in English unless really necessary, and you should only
  write comments for the interface which will be served to other projects.
- The indentation should be 4 spaces if the programming language support that.
- If a method call or method definition have more than one parameter, each
  parameter should be in a separate line unless it's not exceed 80 half-width
  characters per line and it's a method call.
- If a C++ template, C# generic, or equivalent in other languages, have more
  than one parameter, each parameter should be in a separate line unless it's
  not exceed 80 half-width characters per line and it's not a definition.

## Specific rules for C and C++

> [!NOTE]
> The rules here are not comprehensive. When in doubt, reference the Mile.Helpers style:
> - https://github.com/ProjectMile/Mile.Windows.Helpers/tree/main/Mile.Helpers

- Never use `using namespace` in C++ code. Only use `using` with the type
  names that you are using in the current scope to avoid name conflicts as
  much as possible.

  ```cpp
  // BAD!
  using namespace winrt;
  
  // BAD!
  namespace winrt
  {
      using namespace Windows::Foundation;
      using namespace Windows::UI::Xaml;
  }

  // GOOD!
  namespace winrt
  {
      using Windows::Foundation::IInspectable;
      using Windows::UI::Xaml::RoutedEventArgs;
  }
  ```
- If you are using C++/WinRT, all C++/WinRT types should be in the `winrt` namespace.
- Use `nullptr` instead of `NULL` or `0` for null pointer if you are using C++11 or later.
  ```cpp
  // BAD!
  ::Method(NULL);
  
  // GOOD!
  ::Method(nullptr);
  ```
- Do not use initializer lists for better readability and maintainability because the type definition sequence may change later.
  ```cpp
  // BAD!
  VERSION version = { 1, 0, 0, 0 };
  ```
  - An exception for this rule is zero-initialization.
    ```cpp
    Type Value = {};
    ```
  - If possible, prefer direct assignment rather than initializer lists (including zero-initialization).
    ```cpp
    // BAD!
    HWND m_WindowHandle{ nullptr };

    // GOOD!
    HWND m_WindowHandle = nullptr;
    ```
- Use `::` prefix for functions in the global namespace to avoid name conflicts with other namespaces if you are using C++.
  ```cpp
  // BAD!
  Function();

  // GOOD!
  ::Function();
  ```
- Use `this->` prefix for member functions and variables to avoid name conflicts if you are using C++.
  ```cpp
  class Foo
  {
      void Bar();
      int m_number;
  }

  void Foo::Bar()
  {
      // BAD!
      m_number = 1;

      // GOOD!
      this->m_number = 1;
  }
  ```
- Use [SAL](https://learn.microsoft.com/cpp/code-quality/using-sal-annotations-to-reduce-c-cpp-code-defects) for C types in the function and method definitions.
  ```cpp
  // BAD!
  void Method(HWND hwnd);

  // GOOD!
  void Method(_In_ HWND hwnd);
  ```
- Use `Type& OutputParameter` and `Type const& InputParameter` style for C++ types in the function and method definitions.
  ```cpp
  // BAD!
  void Method(winrt::hstring string);

  // GOOD!
  void Method(winrt::hstring const& string);
  ```
- Never eliminate the definition of identifiers for unused parameters.
  ```cpp
  // BAD!
  void Method(winrt::hstring const&);

  // GOOD!
  void Method(winrt::hstring const& string)
  {
      UNREFERENCED_PARAMETER(string);
  }
  ```
- Rules for method calls and method definitions:
  - Prefer a single line for methods with only one parameter or very short method calls.
    ```cpp
    ::Method(param1);
    ::Method(p1, p2);

    void Short(int parameter1);
    ```
  - Otherwise, put each parameter in a separate line.
    ```cpp
    // BAD!
    void VeryLongMethodName(int parameter1, int parameter2);

    // GOOD!
    void VeryLongMethodName(
        int parameter1,
        int parameter2);
    ```
  - Do not put any trailing closing parentheses or semicolons in a separate line.
    ```cpp
    // BAD!
    ::Method(
        parameter1,
        parameter2
    );

    // BAD!
    ::Method(
        parameter1,
        parameter2,
        ::Method2(parameter3)
    );

    // BAD!
    ::Method(
        parameter1,
        parameter2,
        ::Method2(
            parameter3,
            parameter4
        )
    );

    // GOOD!
    ::Method(
        parameter1,
        parameter2);

    // GOOD!
    ::Method(
        parameter1,
        ::Method2(parameter3));

    // GOOD!
    ::Method(
        parameter1,
        parameter2,
        ::Method2(
            parameter3,
            parameter4));
    ```
  - Rule of thumb for indentation is whatever Visual Studio suggests
    with an indentation size of 4 spaces.
    ```cpp
    // 4 spaces lining up to the double colon.
    ::Method(
        parameter1,
        parameter2);

    // 4 spaces lining up to the variable name.
    variable = ::Method(
        paramter1,
        parameter2);
    
    // 4 spaces lining up to the type name.
    Type variable = ::Method(
        paramter1,
        parameter2);
    ```
- The above rules for method definitions also generally apply to templates.
  ```cpp
  // BAD!
  struct AddressBarTemplate : AddressBarTemplateT<AddressBarTemplate, implementation::AddressBarTemplate>
  {
  };

  // GOOD!
  struct AddressBarTemplate : AddressBarTemplateT<
      AddressBarTemplate,
      implementation::AddressBarTemplate>
  {
  };
  ```
- The opening and closing curly brackets should not be in the same line.
  ```cpp
  // BAD!
  struct Foo
  {};

  // GOOD!
  struct Foo
  {
  };
  ```

### Comment Style for C, C++

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
