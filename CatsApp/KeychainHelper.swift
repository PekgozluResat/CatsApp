//
//  KeychainHelper.swift
//  CatsApp
//
//  Created by Resat Pekgozlu on 16/02/2024.
//

import Foundation
import Security

struct KeychainConfiguration {
    static let serviceName = "AppName"
    static let apiKeyAccount = "APIKey"
}

class KeychainHelper {
    
    class func saveAPIKey(apiKey: String) {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: KeychainConfiguration.serviceName,
            kSecAttrAccount as String: KeychainConfiguration.apiKeyAccount,
            kSecValueData as String: apiKey.data(using: .utf8)!
        ]
        
        let status = SecItemAdd(keychainQuery as CFDictionary, nil)
        guard status == errSecSuccess else {
            print("Error saving API key to keychain")
            return
        }
    }
    
    class func loadAPIKey() -> String? {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: KeychainConfiguration.serviceName,
            kSecAttrAccount as String: KeychainConfiguration.apiKeyAccount,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &result)
        guard status == errSecSuccess else {
            print("Error loading API key from keychain")
            return nil
        }
        
        if let apiKeyData = result as? Data {
            return String(data: apiKeyData, encoding: .utf8)
        }
        
        return nil
    }
    
    class func deleteAPIKey() {
        let keychainQuery: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: KeychainConfiguration.serviceName,
            kSecAttrAccount as String: KeychainConfiguration.apiKeyAccount
        ]
        
        let status = SecItemDelete(keychainQuery as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            print("Error deleting API key from keychain")
            return
        }
    }
}
