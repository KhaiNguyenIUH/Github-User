import Foundation

class CacheManager<T: Codable> {
    private let cache = NSCache<NSString, NSData>() // In-memory cache
    private let fileManager = FileManager.default
    private let fileName: String

    init(fileName: String) {
        self.fileName = fileName
    }

    // MARK: - Save Data to Cache
    func save(_ data: T) {
        if let encodedData = try? JSONEncoder().encode(data) {
            cache.setObject(encodedData as NSData, forKey: fileName as NSString)
            saveToDisk(data: encodedData)
        }
    }

    // MARK: - Load Data from Cache
    func load() -> T? {
        // Check in-memory cache
        if let cachedData = cache.object(forKey: fileName as NSString) {
            return decode(data: cachedData as Data)
        }

        // Check persistent storage
        if let diskData = loadFromDisk() {
            cache.setObject(diskData as NSData, forKey: fileName as NSString)
            return decode(data: diskData)
        }

        return nil
    }
    
    // MARK: - Clear Cache
    func clearCache() {
        // Remove from in-memory cache
        cache.removeObject(forKey: fileName as NSString)
        
        // Remove from persistent storage
        let fileURL = getFileURL()
        if fileManager.fileExists(atPath: fileURL.path) {
            do {
                try fileManager.removeItem(at: fileURL)
                print("Cache file removed successfully.")
            } catch {
                print("Error clearing cache: \(error.localizedDescription)")
            }
        }
    }

    // MARK: - Helper Methods
    private func saveToDisk(data: Data) {
        let url = getFileURL()
        try? data.write(to: url)
    }

    private func loadFromDisk() -> Data? {
        let url = getFileURL()
        return try? Data(contentsOf: url)
    }

    private func getFileURL() -> URL {
        let documentDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDir.appendingPathComponent(fileName)
    }

    private func decode(data: Data) -> T? {
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
