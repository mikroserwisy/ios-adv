import Foundation

@propertyWrapper
struct UserProperty<Type> {
    
    let key: String
    let defaultValue: Type
    private var userDefaults = UserDefaults.standard
    
    var wrappedValue: Type {
        get {
            let value = userDefaults.value(forKey: key) as? Type
            return value ?? defaultValue
        }
        set { userDefaults.setValue(newValue, forKey: key) }
    }
    
    init(key: String, defaultValue: Type) {
        self.key = key
        self.defaultValue = defaultValue
    }

}
