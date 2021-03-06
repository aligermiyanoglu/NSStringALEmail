
public class ALEmailValidator {
    fileprivate static var disposableMails : [String] = ALEmailValidator.buildDisposableList()
    
    fileprivate class func domainComponentsAddressFor(email:String) -> [String] {
        let components = email.lowercased().components(separatedBy: "@")
        if components.count > 1 {
            return components[1].components(separatedBy: ".").slicedJoinedArray()
        }
        
        return []
    }
    
    fileprivate class func valid(email:String) -> Bool {
        let mailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}$"
        let mailPredicate = NSPredicate.init(format: "SELF MATCHES %@",mailRegex)
        let result = mailPredicate.evaluate(with: email)
        return result
    }
    
    fileprivate class func buildDisposableList() -> [String] {
        
        let podBundle = Bundle(for: ALEmailValidator.self)
        
        let bundleURL = podBundle.url(forResource: "NSStringALEmail", withExtension: "bundle")
        let bundle = Bundle.init(url: bundleURL!)!
        
        if let path = bundle.path(forResource: "json-disposable-emails", ofType: "txt"){
            let jsonData = try? Data.init(contentsOf: URL(fileURLWithPath: path))
            do {
                let jsonResult = (try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String])!
                return jsonResult
            } catch {
                print("error: \(error)")
            }
            
        }
        return []
    }
    
    public class func blacklist() -> [String] {
        return ALEmailValidator.buildDisposableList()
    }
    
    fileprivate class func checkDomains(_ domains:[String], withBlackList list:[String]) -> Bool {
        for item in domains {
            for blackListedItem in list {
                if item == blackListedItem.lowercased() {
                    return true
                }
            }
        }
        return false
    }
    
    fileprivate class func disposable(email:String) -> Bool {
        let domains = ALEmailValidator.domainComponentsAddressFor(email: email)
        return checkDomains(domains, withBlackList: disposableMails)
    }
}

fileprivate extension Array where Element : ExpressibleByStringLiteral  {
    fileprivate func joinedComponentsArray() -> String {
        var accumulator = ""
        if self.count > 0 {
            accumulator = String(describing: self[0])
        
            if (self.count > 1) {
                for index in 1...self.count-1 {
                    accumulator = accumulator + "." + String(describing: self[index])
                }
            }
        }
        
        
        return accumulator
    }
    
    fileprivate func slicedJoinedArray() -> [String] {
        var result:[String] = Array<String>()
        for (index, _) in self.reversed().enumerated() {
            let sub = self.subArrayFrom(index: index)
            result.append(sub.joinedComponentsArray())
        }
        
        return result
    }
}

fileprivate extension Array  {
    fileprivate func subArrayFrom(index:Int) -> Array {
        return Array(self[index..<self.count])
    }
}

public extension String {
    public func validEmail() -> Bool {
        return ALEmailValidator.valid(email: self)
    }
    
    public func disposableEmail() -> Bool {
        return ALEmailValidator.disposable(email: self)
    }
}

@objc public extension NSString {
    @objc func validEmail() -> Bool {
        return ALEmailValidator.valid(email: (self as String))
    }
    
    @objc func disposableEmail() -> Bool {
        return ALEmailValidator.disposable(email: (self as String))
    }
}
