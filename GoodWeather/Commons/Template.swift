import Foundation

final class Template {
    
    private let text: String
    private let expressionPattern = try! NSRegularExpression(pattern: "\\$\\{\\w+\\}")
    
    init(_ text: String) {
        self.text = text
    }
    
    func evaluate(with parameters: [String: String]) throws -> String {
        let result = substitute(parameters)
        try validate(result)
        return result
    }
    
    private func substitute(_ parameters: [String: String]) -> String {
        var result = text
        for (key, value) in parameters {
            result = result.replacingOccurrences(of: "${\(key)}", with: value)
        }
        return result
    }
    
    private func validate(_ result: String) throws {
        if expressionPattern.firstMatch(in: result, options: [], range: range(for: result)) != nil {
            throw TemplateError.missingParameter
        }
    }
    
    private func range(for text: String) -> NSRange {
        NSRange(location: 0, length: text.utf16.count)
    }
    
}

enum TemplateError: Error {
    
    case missingParameter
    
}
