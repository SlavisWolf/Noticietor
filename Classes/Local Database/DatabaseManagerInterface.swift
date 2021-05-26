//
//  DatabaseManagerProtocol.swift
//
//
//  
//
import CoreData
// Si creamos mas managers deberian cumplir esta estructura
protocol DatabaseManagerInterface {
    
    associatedtype ObjectContext
    associatedtype Model
    
    // Metodos para modificar
    func save(_ model: Model)
    func saveList(_ models: [Model])
    func deleteObsoleteValues(_ validIds: [Int])
    func createOrUpdate(_ model: Model)
    
    // Metodos para leer
    func get(_ id: Int) -> Model?
    func getAll(_ predicate: NSPredicate?) -> [Model]
    func getObject(_ id: Int) -> ObjectContext?
    
    // Mapeo
    func mappingContextObject(_ object: ObjectContext) -> Model
    func mappingContextObjects(_ objects: [ObjectContext]) -> [Model]
    func castToContextObject(_ group: Model)  -> ObjectContext
}
