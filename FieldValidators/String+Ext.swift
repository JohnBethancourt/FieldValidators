import Foundation

extension String{
    
    func isValidICAO() -> Bool {
        guard self.count == 4 else { return false }
        let validSet = Set("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        return Set(self).isSubset(of: validSet)
    }
    func isExactlyFourCharacters() -> Bool {
        return self.count == 4
    }
    
    var isDigits: Bool {
        guard self.count > 0 else { return false }
        let digits = Set("0123456789")
        return Set(self).isSubset(of: digits)
    }
    
}
