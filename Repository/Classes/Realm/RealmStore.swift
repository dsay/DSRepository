import RealmSwift

open class RealmStore<Item: Object>: LocalStore {
    
    public let context: Realm
    
    public init(_ context: Realm) {
        self.context = context
    }
    
    public func getItem() -> Item? {
        return context.objects(Item.self).first
    }
    
    public func getItems() -> [Item] {
        return context.objects(Item.self).compactMap { $0 }
    }
    
    public func get(with id: Int) -> Item? {
        let predicate = NSPredicate(format: "%K = %d", Item.primaryKey() ?? "", id)
        return context.objects(Item.self).filter(predicate).first
    }
    
    public func get(with id: String) -> Item? {
        let predicate = NSPredicate(format: "%K = %@", Item.primaryKey() ?? "", id)
        return context.objects(Item.self).filter(predicate).first
    }
    
    public func get(with predicate: NSPredicate) -> [Item] {
        return context.objects(Item.self).filter(predicate).compactMap { $0 }
    }
    
    public func update(_ transaction: () -> Void) throws {
        do {
            try context.write {
                transaction()
            }
        } catch {
            throw error
        }
    }
    
    public func save(_ item: Item) throws {
        do {
            try context.write {
                context.add(item, update: true)
            }
        } catch {
            throw error
        }
    }
    
    public func save(_ items: [Item]) throws {
        do {
            try context.write {
                context.add(items, update: true)
            }
        } catch {
            throw error
        }
    }
    
    public func remove(_ item: Item) throws {
        do {
            try context.write {
                context.delete(item)
            }
        } catch {
            throw error
        }
    }
    
    public func remove(_ items: [Item]) throws {
        do {
            try context.write {
                context.delete(items)
            }
        } catch {
            throw error
        }
    }
}
