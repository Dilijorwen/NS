import Foundation
import CommonCrypto

func sha256(_ input: String) -> String {
    if let inputData = input.data(using: .utf8) {
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        _ = inputData.withUnsafeBytes {
            CC_SHA256($0.baseAddress, CC_LONG(inputData.count), &hash)
        }
        
        let hashData = Data(hash)
        let hashString = hashData.map { String(format: "%02hhx", $0) }.joined()
        
        return hashString
    }
    
    return ""
}
