// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum ProjectLanguage {
  /// test value
  public static var test2222: String { return ProjectLanguage.tr("Localizable", "Test2222") }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension ProjectLanguage {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    let lang = (UserDefaults.standard.value(forKey: "AppleLanguages") as? [String])?.first ?? "en"
    return String(format: format, locale: Locale.init(identifier: lang), arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static var bundle: Bundle {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    let lang = (UserDefaults.standard.value(forKey: "AppleLanguages") as? [String])?.first ?? "en"
    guard let path = Bundle(for: BundleToken.self).path(forResource: lang, ofType: "lproj") else {
        return Bundle(for: BundleToken.self)
    }
    return Bundle(path: path) ?? Bundle(for: BundleToken.self)
    #endif
  }
}
// swiftlint:enable convenience_type
