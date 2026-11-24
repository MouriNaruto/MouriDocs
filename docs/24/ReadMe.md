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
- Use "PascalCase" for **all identifiers** unless really necessary.
- Use Allman style for braces if the language has braces unless the language
  don't support Allman style for braces.
- Only use Hungarian notation in these scenarios:
  - Use the `g_` prefix only for private global variables of source files.
  - Use the `m_` prefix only for private member variables of classes or structs.
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
- Try `do { ... } while (false);` first before you want to write `goto label;`.

## Specific rules for C and C++

> [!NOTE]
> The rules here are not comprehensive. When in doubt, reference the Mile.Helpers style:
> - https://github.com/ProjectMile/Mile.Windows.Helpers/tree/main/Mile.Helpers

> [!NOTE]
> For how to name acceptable identifiers, learn from the fastfat driver in
> Windows Driver Examples will be much helpful to make Kenji Mouri satisfied:
> - https://github.com/microsoft/Windows-driver-samples/tree/main/filesys/fastfat

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
  VERSION Version = { 1, 0, 0, 0 };
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
      int m_Number;
  }

  void Foo::Bar()
  {
      // BAD!
      m_Number = 1;

      // GOOD!
      this->m_Number = 1;
  }
  ```
- Use [SAL](https://learn.microsoft.com/cpp/code-quality/using-sal-annotations-to-reduce-c-cpp-code-defects) for C types in the function and method definitions.
  ```cpp
  // BAD!
  void Method(HWND WindowHandle);

  // GOOD!
  void Method(_In_ HWND WindowHandle);
  ```
- Use `Type& OutputParameter` and `Type const& InputParameter` style for C++ types in the function and method definitions.
  ```cpp
  // BAD!
  void Method(winrt::hstring String);

  // GOOD!
  void Method(winrt::hstring const& String);
  ```
- Never eliminate the definition of identifiers for unused parameters.
  ```cpp
  // BAD!
  void Method(winrt::hstring const&);

  // GOOD!
  void Method(winrt::hstring const& String)
  {
      UNREFERENCED_PARAMETER(String);
  }
  ```
- Rules for method calls and method definitions:
  - Prefer a single line for methods with only one parameter or very short method calls.
    ```cpp
    ::Method(Param1);
    ::Method(P1, P2);

    void Short(int Parameter1);
    ```
  - Otherwise, put each parameter in a separate line.
    ```cpp
    // BAD!
    void VeryLongMethodName(int Parameter1, int Parameter2);

    // GOOD!
    void VeryLongMethodName(
        int Parameter1,
        int Parameter2);
    ```
  - Do not put any trailing closing parentheses or semicolons in a separate line.
    ```cpp
    // BAD!
    ::Method(
        Parameter1,
        Parameter2
    );

    // BAD!
    ::Method(
        Parameter1,
        Parameter2,
        ::Method2(Parameter3)
    );

    // BAD!
    ::Method(
        Parameter1,
        Parameter2,
        ::Method2(
            Parameter3,
            Parameter4
        )
    );

    // GOOD!
    ::Method(
        Parameter1,
        Parameter2);

    // GOOD!
    ::Method(
        Parameter1,
        ::Method2(Parameter3));

    // GOOD!
    ::Method(
        Parameter1,
        Parameter2,
        ::Method2(
            Parameter3,
            Parameter4));
    ```
  - Rule of thumb for indentation is whatever Visual Studio suggests
    with an indentation size of 4 spaces.
    ```cpp
    // 4 spaces lining up to the double colon.
    ::Method(
        Parameter1,
        Parameter2);

    // 4 spaces lining up to the variable name.
    variable = ::Method(
        Parameter1,
        Parameter2);
    
    // 4 spaces lining up to the type name.
    Type variable = ::Method(
        Parameter1,
        Parameter2);
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

> [!NOTE]
> For multiline descriptions, keep the leading `*` and align continuation text
> with the first line's description, as shown below.

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
     *        decide the system-drawn backdrop material for this window.
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

## Helpful notes from `gpt-6.1-sol`

> [!NOTE]
> These notes explain how to read and apply the existing guidelines. They do
> not introduce additional coding rules or replace reading the guidelines and
> the relevant project code.

- Read the specific rules through the coding philosophy: readability first,
  and prefer explicit than implicit. Naming, types, control flow, comments,
  and formatting work together. Following each rule in isolation does not
  necessarily make the resulting implementation readable.
- Names carry much of the explanation inside an implementation. Prefer names
  that distinguish roles, states, and units, rather than names that merely
  distinguish variables. For example, `RequestedSize` and `AllocatedSize`
  describe different quantities; `Size1` and `Size2` do not explain that
  difference. Abbreviations can move the burden of explanation from the code
  to the reader's memory.
  - API prefixes also convey ownership and layering. Follow the existing
    subsystem and capability names, such as `K7BaseHashCreate` and
    `MoMemorySmallHeapAllocate`, rather than inventing a new naming scheme.
  - Preserve names required by existing system interfaces and external
    definitions. Their presence does not establish a naming convention for
    unrelated new code.
- Understand the actual types before adding conversions. Check the underlying
  type, width, signedness, pointer qualification, and interface contract.
  Equal sizes alone do not make two types, or pointers to them, interchangeable.
  Choose suitable types and existing conversion utilities first. A necessary
  conversion should express a real boundary; hiding a cast in a macro or a
  helper does not establish that the conversion is correct.
  - Distinguish fixed-width values from native-width values, byte sizes from
    character counts, and requested sizes from buffer capacities. Check integer
    promotions, alignment, and layout assumptions where they matter.
  - Qualifiers and synchronization have specific meanings. A volatile pointer
    and a pointer to volatile data are different; volatile access, atomic
    operations, compiler barriers, and hardware barriers are not interchangeable.
- Use comments primarily to document interfaces: parameters, return values,
  ownership, output state on failure, and calling requirements. Let names,
  types, and control flow explain the implementation. When an implementation
  comment is necessary, explain a non-obvious reason or constraint rather than
  narrating the next statement. Do not compensate for unclear code by adding
  step-by-step commentary.
- Similar-looking operations are not automatically the same abstraction.
  Explicit handling can be easier to review when resources have different
  roles or lifetimes. Arrays and tables remain appropriate for genuine
  collections with meaningful indexing. Likewise, a short forwarding function
  can be useful when it defines a platform or interface boundary; its value is
  not determined by the number of statements it contains.
- Read declarations together with implementations and callers. Verify units,
  capacity, termination, failure behavior, and resource ownership instead of
  inferring them from a function name. Reuse the project's existing facilities,
  checking the dependency version actually used by the project.
  - Preserve the existing ABI, calling convention, data layout, and error model.
    An implementation written in C++ does not require exposing C++ types or
    ownership conventions through a C interface.
  - Do not import assumptions from a desktop application into a freestanding
    component, or assume that a restriction of one layer applies to every other
    layer. Existing code is a reference to understand, not proof that every
    local exception or third-party convention should be copied.
- Review operations in execution order. Consider when state becomes visible,
  which operations can invalidate earlier assumptions, who owns a resource
  after a transfer, and whether cleanup changes the original error. Failure
  does not universally mean that outputs should be cleared or that every
  resource should be released: follow the particular interface contract.
  - Keep distinctions between error conditions and between a successful result
    and a false condition. Do not publish success before required initialization
    finishes, or mistake safe static initialization for thread-safe mutation.
  - Make validation match its purpose. Arithmetic range checks do not establish
    that memory is mapped or accessible. Check overflow, overlap, encoding, and
    termination according to the operation, rather than adding checks merely
    because they look defensive.
- Preserve behavior outside the scope of a replacement or workaround. Handle
  the cases that the new implementation can correctly support and retain the
  established fallback for other cases. Do not silently broaden an encoding
  contract, weaken an existing policy, or change output and exit-code semantics
  as an incidental part of a fix.
- A small change should have a small, justified scope, not merely a short diff.
  Avoid unrelated abstractions and behavior changes, but do not omit necessary
  failure handling to reduce line count. Before submitting, make sure you can
  explain both what each added line does and why it belongs in this project.
  Build and test in the supported environment, including failure and fallback
  paths, and review the patch yourself. Successful compilation and tests do not
  establish that an abstraction, type choice, or coding style is appropriate.
