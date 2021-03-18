//
// ViewsChanges.swift
//
// Copyright (c) 2021 R.SK Lab Ltd. All Rights Reserved.
//
// Licensed under the RPL-1.5 and R.SK Lab Professional licenses
// (the "Licenses"); you may not use this work except in compliance
// with the Licenses. You may obtain a copy of the Licenses in
// the LICENSE_RPL and LICENSE_RSK_LAB_PROFESSIONAL files.
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the Licenses is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied.
//

import RSKFoundation

/// The type of object that represents changes to a collection of views.
public struct ViewsChanges: ObjectProtocol {
    
    /// The type of object that represents a deletion of the view.
    public typealias ViewDeletion = IndexPath
    
    /// The type of object that represents an insertion of the view.
    public typealias ViewInsertion = IndexPath
    
    /// The type of object that represents a movement of the view.
    public typealias ViewMovement = (indexPath: IndexPath, newIndexPath: IndexPath)
    
    /// The type of object that represents a deletion of the views section.
    public typealias ViewsSectionDeletion = Int
    
    /// The type of object that represents an insertion of the views section.
    public typealias ViewsSectionInsertion = Int
    
    /// The type of object that represents a movement of the views section.
    public typealias ViewsSectionMovement = (index: Int, newIndex: Int)
    
    /// The type of object that represents an update of the views section.
    public typealias ViewsSectionUpdate = Int
    
    /// The type of object that represents an update of the view.
    public typealias ViewUpdate = IndexPath
    
    // MARK: - Public Properties
    
    /// An array of `ViewDeletion` objects.
    public let viewDeletions: [ViewDeletion]
    
    /// An array of `ViewInsertion` objects.
    public let viewInsertions: [ViewInsertion]
    
    /// A array of `ViewMovement` objects.
    public let viewMovements: [ViewMovement]
    
    /// A set of `ViewsSectionDeletion` objects.
    public let viewsSectionDeletions: IndexSet
    
    /// A set of `ViewsSectionInsertion` objects.
    public let viewsSectionInsertions: IndexSet
    
    /// An array of `ViewsSectionMovement` objects.
    public let viewsSectionMovements: [ViewsSectionMovement]
    
    /// A set of `ViewsSectionUpdate` objects.
    public let viewsSectionUpdates: IndexSet
    
    /// An array of `ViewUpdate` objects.
    public let viewUpdates: [ViewUpdate]
    
    // MARK: - Public Initializers
    
    ///
    /// Initializes and returns a new `ViewsChanges` object with parameters that are created from the specified `objectsChanges`.
    ///
    /// - Parameters:
    ///     - objectsChanges: Changes to a collection of objects.
    ///
    public init<ObjectIdentifierType: Hashable>(objectsChanges: ObjectsChanges<ObjectIdentifierType>) {
        
        self.init(objectsChanges: objectsChanges,
                  shouldMovementsBePerformedAlongWithOtherChanges: true)
    }
    
    ///
    /// Initializes and returns a new `ViewsChanges` object with parameters that are created from the specified `objectsChanges` and `shouldMovementsBePerformedAlongWithOtherChanges` .
    ///
    /// - Parameters:
    ///     - objectsChanges: Changes to a collection of objects.
    ///     - shouldMovementsBePerformedAlongWithOtherChanges: `true` if the movements should be performed along with other changes, `false` otherwise.
    ///
    public init<ObjectIdentifierType: Hashable>(objectsChanges: ObjectsChanges<ObjectIdentifierType>,
                                                shouldMovementsBePerformedAlongWithOtherChanges: Bool) {
        
        let viewsSectionDeletions = IndexSet()
        let viewsSectionInsertions = IndexSet()
        let viewsSectionMovements = [ViewsSectionMovement]()
        let viewsSectionUpdates = IndexSet()
        
        self.init(objectsChanges: objectsChanges,
                  viewsSectionDeletions: viewsSectionDeletions,
                  viewsSectionInsertions: viewsSectionInsertions,
                  viewsSectionMovements: viewsSectionMovements,
                  viewsSectionUpdates: viewsSectionUpdates,
                  shouldMovementsBePerformedAlongWithOtherChanges: shouldMovementsBePerformedAlongWithOtherChanges)
    }
    
    ///
    /// Initializes and returns a new `ViewsChanges` object with parameters that are created from the specified `objectsSectionsChanges` and `objectsChanges`.
    ///
    /// - Parameters:
    ///     - objectsSectionsChanges: Changes to a collection of sections of objects.
    ///     - objectsChanges: Changes to a collection of objects.
    ///
    public init<ObjectIdentifierType: Hashable, ObjectsSectionIdentifierType: Hashable>(objectsSectionsChanges: ObjectsChanges<ObjectsSectionIdentifierType>,
                                                                                        objectsChanges: ObjectsChanges<ObjectIdentifierType>) {
        
        self.init(objectsSectionsChanges: objectsSectionsChanges,
                  objectsChanges: objectsChanges,
                  shouldMovementsBePerformedAlongWithOtherChanges: true)
    }
    
    ///
    /// Initializes and returns a new `ViewsChanges` object with parameters that are created from the specified `objectsSectionsChanges`, `objectsChanges` and `shouldMovementsBePerformedAlongWithOtherChanges`.
    ///
    /// - Parameters:
    ///     - objectsSectionsChanges: Changes to a collection of sections of objects.
    ///     - objectsChanges: Changes to a collection of objects.
    ///     - shouldMovementsBePerformedAlongWithOtherChanges: `true` if the movements should be performed along with other changes, `false` otherwise.
    ///
    public init<ObjectIdentifierType: Hashable, ObjectsSectionIdentifierType: Hashable>(objectsSectionsChanges: ObjectsChanges<ObjectsSectionIdentifierType>,
                                                                                        objectsChanges: ObjectsChanges<ObjectIdentifierType>,
                                                                                        shouldMovementsBePerformedAlongWithOtherChanges: Bool) {
        
        var objectsSectionsChangesObjectInsertions = objectsSectionsChanges.objectInsertions
        
        // Make `viewsSectionUpdates`.
        
        var viewsSectionUpdates = IndexSet(objectsSectionsChanges.objectUpdates.map { (objectsSectionUpdate) -> ViewsSectionInsertion in
            
            objectsSectionUpdate.objectIndexPath.section
        })
        
        // Make `viewsSectionDeletions`.
        
        var viewsSectionDeletions = IndexSet()
        objectsSectionsChanges.objectDeletions.forEach { (objectsSectionDeletion) in
            
            let firstIndex = objectsSectionsChangesObjectInsertions.firstIndex(where: { (objectsSectionInsertion) -> Bool in
                
                objectsSectionInsertion.objectIndexPath.section == objectsSectionDeletion.objectIndexPath.section
            })
            if let index = firstIndex {
                
                objectsSectionsChangesObjectInsertions.remove(at: index)
                viewsSectionUpdates.insert(objectsSectionDeletion.objectIndexPath.section)
            }
            else {
                
                viewsSectionDeletions.insert(objectsSectionDeletion.objectIndexPath.section)
            }
        }
        
        // Make `viewsSectionInsertions`.
        
        let viewsSectionInsertions = IndexSet(objectsSectionsChangesObjectInsertions.map { (objectsSectionInsertion) -> ViewsSectionInsertion in
            
            objectsSectionInsertion.objectIndexPath.section
        })
        
        // Make `viewsSectionMovements`.
        
        var viewsSectionMovements = [ViewsSectionMovement]()
        objectsSectionsChanges.objectMovements.forEach { (objectsSectionMovement) in
            
            let viewsSectionMovement: ViewsSectionMovement
            if shouldMovementsBePerformedAlongWithOtherChanges == true {
                
                viewsSectionMovement = (index: objectsSectionMovement.objectOldIndexPath.section, newIndex: objectsSectionMovement.objectNewIndexPath.section)
            }
            else {
                
                var viewsSectionMovementIndex = viewsSectionInsertions.reduce(objectsSectionMovement.objectOldIndexPath.section, { (viewsSectionMovementIndex, viewsSectionInsertion) -> Int in
                    
                    viewsSectionInsertion <= objectsSectionMovement.objectOldIndexPath.section ? viewsSectionMovementIndex + 1 : viewsSectionMovementIndex
                })
                viewsSectionMovementIndex = viewsSectionDeletions.reduce(viewsSectionMovementIndex, { (viewMovementIndexPathItem, viewsSectionDeletion) -> Int in
                    
                    viewsSectionDeletion < objectsSectionMovement.objectOldIndexPath.section ? viewMovementIndexPathItem - 1 : viewMovementIndexPathItem
                })
                viewsSectionMovement = (index: viewsSectionMovementIndex, newIndex: objectsSectionMovement.objectNewIndexPath.section)
            }
            
            guard viewsSectionDeletions.contains(viewsSectionMovement.newIndex) == false,
                  viewsSectionUpdates.contains(viewsSectionMovement.newIndex) == false else {
                
                if viewsSectionUpdates.contains(viewsSectionMovement.index) == false {
                    
                    viewsSectionUpdates.insert(viewsSectionMovement.index)
                }
                return
            }
            viewsSectionMovements.append(viewsSectionMovement)
        }
        
        self.init(objectsChanges: objectsChanges,
                  viewsSectionDeletions: viewsSectionDeletions,
                  viewsSectionInsertions: viewsSectionInsertions,
                  viewsSectionMovements: viewsSectionMovements,
                  viewsSectionUpdates: viewsSectionUpdates,
                  shouldMovementsBePerformedAlongWithOtherChanges: shouldMovementsBePerformedAlongWithOtherChanges)
    }
    
    // MARK: - Private Initializers
    
    private init<ObjectIdentifierType: Hashable>(objectsChanges: ObjectsChanges<ObjectIdentifierType>,
                                                 viewsSectionDeletions: IndexSet,
                                                 viewsSectionInsertions: IndexSet,
                                                 viewsSectionMovements: [ViewsSectionMovement],
                                                 viewsSectionUpdates: IndexSet,
                                                 shouldMovementsBePerformedAlongWithOtherChanges: Bool) {
        
        var objectsChangesObjectDeletions = objectsChanges.objectDeletions
        var objectsChangesObjectInsertions = objectsChanges.objectInsertions
        
        // Filter `objectsChanges.objectMovements`.
        
        var objectsChangesObjectMovements = objectsChanges.objectMovements
        objectsChanges.objectMovements.forEach { (objectMovement) in
            
            guard objectMovement.objectNewIndexPath.section != objectMovement.objectOldIndexPath.section else {
                
                return
            }
            
            objectsChangesObjectMovements.remove(objectMovement)
            
            if viewsSectionDeletions.contains(objectMovement.objectOldIndexPath.section) == false,
               viewsSectionUpdates.contains(objectMovement.objectOldIndexPath.section) == false {
                
                let objectDeletion = ObjectsChanges<ObjectIdentifierType>.ObjectDeletion(
                    
                    objectIdentifier: objectMovement.objectIdentifier,
                    objectIndexPath: objectMovement.objectOldIndexPath
                )
                objectsChangesObjectDeletions.insert(objectDeletion)
            }
            
            if viewsSectionInsertions.contains(objectMovement.objectNewIndexPath.section) == false,
               viewsSectionUpdates.contains(objectMovement.objectNewIndexPath.section) == false {
                
                let objectInsertion = ObjectsChanges<ObjectIdentifierType>.ObjectInsertion(
                    
                    objectIdentifier: objectMovement.objectIdentifier,
                    objectIndexPath: objectMovement.objectNewIndexPath
                )
                objectsChangesObjectInsertions.insert(objectInsertion)
            }
        }
        
        // Make `viewUpdates`.
        
        var viewUpdates = objectsChanges.objectUpdates.compactMap { (objectUpdate) -> ViewUpdate? in
            
            viewsSectionUpdates.contains(objectUpdate.objectIndexPath.section) == false ? objectUpdate.objectIndexPath : nil
        }
        
        // Make `viewDeletions`.
        
        var viewDeletions = [ViewDeletion]()
        objectsChangesObjectDeletions.forEach { (objectDeletion) in
            
            guard viewsSectionDeletions.contains(objectDeletion.objectIndexPath.section) == false,
                  viewsSectionUpdates.contains(objectDeletion.objectIndexPath.section) == false else {
                
                return
            }
            let firstIndex = objectsChangesObjectInsertions.firstIndex(where: { (objectInsertion) -> Bool in
                
                objectInsertion.objectIndexPath == objectDeletion.objectIndexPath
            })
            if let index = firstIndex {
                
                objectsChangesObjectInsertions.remove(at: index)
                viewUpdates.append(objectDeletion.objectIndexPath)
            }
            else {
                
                viewDeletions.append(objectDeletion.objectIndexPath)
            }
        }
        
        // Make `viewInsertions`.
        
        let viewInsertions = objectsChangesObjectInsertions.compactMap { (objectInsertion) -> ViewInsertion? in
            
            guard viewsSectionInsertions.contains(objectInsertion.objectIndexPath.section) == false,
                  viewsSectionUpdates.contains(objectInsertion.objectIndexPath.section) == false else {
                
                return nil
            }
            return objectInsertion.objectIndexPath
        }
        
        // Make `viewMovements`.
        
        var viewMovements = [ViewMovement]()
        objectsChangesObjectMovements.reversed().forEach { (objectMovement) in
            
            let viewMovement: ViewMovement
            if shouldMovementsBePerformedAlongWithOtherChanges == true {
                
                viewMovement = (indexPath: objectMovement.objectOldIndexPath, newIndexPath: objectMovement.objectNewIndexPath)
            }
            else {
                
                var viewMovementIndexPathItem = viewInsertions.reduce(objectMovement.objectOldIndexPath.item, { (viewMovementIndexPathItem, viewInsertion) -> Int in
                    
                    viewInsertion.section == objectMovement.objectOldIndexPath.section && viewInsertion.item <= objectMovement.objectOldIndexPath.item ? viewMovementIndexPathItem + 1 : viewMovementIndexPathItem
                })
                viewMovementIndexPathItem = viewDeletions.reduce(viewMovementIndexPathItem, { (viewMovementIndexPathItem, viewDeletion) -> Int in
                    
                    viewDeletion.section == objectMovement.objectOldIndexPath.section && viewDeletion.item < objectMovement.objectOldIndexPath.item ? viewMovementIndexPathItem - 1 : viewMovementIndexPathItem
                })
                var viewMovementIndexPathSection = viewsSectionInsertions.reduce(objectMovement.objectOldIndexPath.section, { (viewMovementIndexPathSection, viewsSectionInsertion) -> Int in
                    
                    viewsSectionInsertion <= objectMovement.objectOldIndexPath.section ? viewMovementIndexPathSection + 1 : viewMovementIndexPathSection
                })
                viewMovementIndexPathSection = viewsSectionDeletions.reduce(viewMovementIndexPathSection, { (viewMovementIndexPathSection, viewsSectionDeletion) -> Int in
                    
                    viewsSectionDeletion < objectMovement.objectOldIndexPath.section ? viewMovementIndexPathSection - 1 : viewMovementIndexPathSection
                })
                let viewMovementIndexPath = IndexPath(item: viewMovementIndexPathItem, section: viewMovementIndexPathSection)
                viewMovement = (indexPath: viewMovementIndexPath, newIndexPath: objectMovement.objectNewIndexPath)
            }
            guard viewDeletions.contains(viewMovement.newIndexPath) == false,
                  viewUpdates.contains(viewMovement.newIndexPath) == false else {
                
                if viewUpdates.contains(viewMovement.indexPath) == false {
                    
                    viewUpdates.append(viewMovement.indexPath)
                }
                return
            }
            viewMovements.append(viewMovement)
        }
        
        // Initialize attributes.
        
        self.viewDeletions = viewDeletions
        self.viewInsertions = viewInsertions
        self.viewMovements = viewMovements
        self.viewsSectionDeletions = viewsSectionDeletions
        self.viewsSectionInsertions = viewsSectionInsertions
        self.viewsSectionMovements = viewsSectionMovements
        self.viewsSectionUpdates = viewsSectionUpdates
        self.viewUpdates = viewUpdates
    }
}
