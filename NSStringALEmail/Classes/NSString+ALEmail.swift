
public class ALEmailValidator {
    private static var disposableMailList : [String] = ALEmailValidator.buildDisposableList()
    
    private class func domainComponentsAddressFor(email email:String) -> [String] {
        let components = email.lowercaseString.componentsSeparatedByString("@")
        if components.count > 1 {
            return components[1].componentsSeparatedByString(".").slicedJoinedArray()
        }
        
        return []
    }
    
    private class func isValid(email email:String) -> Bool {
        let mailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
        let mailPredicate = NSPredicate.init(format: "SELF MATCHES %@",mailRegex)
        let result = mailPredicate.evaluateWithObject(email)
        return result
    }
    
    private class func buildDisposableList() -> [String] {
        
        let podBundle = NSBundle(forClass: ALEmailValidator.self)
        
        let bundleURL = podBundle.URLForResource("NSStringALEmail", withExtension: "bundle")
        let bundle = NSBundle.init(URL: bundleURL!)!
        
        if let path = bundle.pathForResource("json-disposable-emails", ofType: "txt"){
            let jsonData = NSData.init(contentsOfFile: path)
            do {
                let jsonResult = (try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers) as? [String])!
                return jsonResult
            } catch {
                print("error: \(error)")
            }
            
        }
        return []
    }
    
    private class func checkDomains(domains:[String], withBlackList list:[String]) -> Bool {
        for item in domains {
            for blackListedItem in list {
                if item == blackListedItem {
                    return true
                }
            }
        }
        return false
    }
    
    private class func isDisposable(email email:String) -> Bool {
        let domains = ALEmailValidator.domainComponentsAddressFor(email: email)
        return checkDomains(domains, withBlackList: disposableMailList)
    }
}

extension Array where Element : StringLiteralConvertible  {
    func joinedComponentsArray() -> String {
        var accumulator = ""
        if self.count > 0 {
            accumulator = String(self[0])
        
            if (self.count > 1) {
                for index in 1...self.count-1 {
                    accumulator = accumulator + "." + String(self[index])
                }
            }
        }
        
        
        return accumulator
    }
    
    func slicedJoinedArray() -> [String] {
        var result:[String] = Array<String>()
        for (index, _) in self.reverse().enumerate() {
            let sub = self.subArrayFrom(index: index)
            result.append(sub.joinedComponentsArray())
        }
        
        return result
    }
}

extension Array  {
    func subArrayFrom(index index:Int) -> Array {
        return Array(self[index..<self.count])
    }
}

public extension String {
    func isValidEmail() -> Bool {
        return ALEmailValidator.isValid(email: self)
    }
    
    func isDisposableEmail() -> Bool {
        return ALEmailValidator.isDisposable(email: self)
    }
}

public extension NSString {
    func isValidEmail() -> Bool {
        return ALEmailValidator.isValid(email: (self as String))
    }
    
    func isDisposableEmail() -> Bool {
        return ALEmailValidator.isDisposable(email: (self as String))
    }
}