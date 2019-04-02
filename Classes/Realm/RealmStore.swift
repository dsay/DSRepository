import RealmSwift

public class RealmStore<Item: Object>: LocalStore {

    let context: Realm

    init(_ context: Realm) {
        self.context = context
    }

    func getItem() -> Item? {
        return context.objects(Item.self).first
    }

    func getItems() -> [Item] {
        return context.objects(Item.self).compactMap { $0 }
    }

    func get(with id: Int) -> Item? {
        let predicate = NSPredicate(format: "%K = %d", Item.primaryKey() ?? "", id)
        return context.objects(Item.self).filter(predicate).first
    }

    func get(with id: String) -> Item? {
        let predicate = NSPredicate(format: "%K = %@", Item.primaryKey() ?? "", id)
        return context.objects(Item.self).filter(predicate).first
    }

    func get(with predicate: NSPredicate) -> [Item] {
        return context.objects(Item.self).filter(predicate).compactMap { $0 }
    }

    func update(_ transaction: () -> Void) throws {
        do {
            try context.write {
                transaction()
            }
        } catch {
            throw error
        }
    }

    func save(_ item: Item) throws {
        do {
            try context.write {
                context.add(item, update: true)
            }
        } catch {
            throw error
        }
    }

    func save(_ items: [Item]) throws {
        do {
            try context.write {
                context.add(items, update: true)
            }
        } catch {
            throw error
        }
    }

    func remove(_ item: Item) throws {
        do {
            try context.write {
                context.delete(item)
            }
        } catch {
            throw error
        }
    }

    func remove(_ items: [Item]) throws {
        do {
            try context.write {
                context.delete(items)
            }
        } catch {
            throw error
        }
    }
}
