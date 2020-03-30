//
//  SavedPlayer+CoreDataProperties.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 3/27/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//
//

import Foundation
import CoreData


extension SavedPlayer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedPlayer> {
        return NSFetchRequest<SavedPlayer>(entityName: "SavedPlayer")
    }

    @NSManaged public var name: String?
    @NSManaged public var playerImage: Data?
    @NSManaged public var power: Int16
    @NSManaged public var sprLoses: Int16
    @NSManaged public var sprWins: Int16
    @NSManaged public var stndLoses: Int16
    @NSManaged public var stndWins: Int16

}
