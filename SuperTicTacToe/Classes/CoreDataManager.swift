//
//  CoreDataManager.swift
//  SuperTicTacToe
//
//  Created by David Ennis on 3/25/20.
//  Copyright © 2020 Apps By Ennis. All rights reserved.
//

import UIKit
import CoreData

// I know this is a learning project, and it's cool to use Core Data to help learn it
// but in production, this app does not need Core Data. For small data values, just use the Codable
// protocol and write a JSON file to disk.
final class CoreDataManager {
    
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    static let shared = CoreDataManager()
    
    private init() {
        
    }
    
    func pullDataFromCoreData() -> [SavedPlayer]? {
        var coreDataArray: [SavedPlayer]
        print("pullDataFromCoreData called")
        do {
            coreDataArray = try context.fetch(SavedPlayer.fetchRequest())
            if coreDataArray.count > 0 {
                print("CoreData not empty")
                return coreDataArray
            } else {
                print("Core Data empty")
                return nil
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func saveToCoreData(data: Player) {
        print("saveToCoreData called")
        let player = SavedPlayer(entity: SavedPlayer.entity(), insertInto: context)
        player.name = data.getPlayerName()
        player.power = Int16(data.displayPower())
        player.stndWins = Int16(data.getStndWinsLoses().0)
        player.stndLoses = Int16(data.getStndWinsLoses().1)
        player.sprWins = Int16(data.getSprWinsLoses().0)
        player.sprLoses = Int16(data.getSprWinsLoses().1)
        player.accountType = Int16(data.getAccountType())
        if data.getPlayerImage() != nil {
            player.playerImage = data.getPlayerImage()?.pngData() as Data?
        }
        
        
        do {
            try context.save()
            print("player data saved to Core Data")
        } catch {
            print("Could not save. \(error), \(error.localizedDescription)")
        }
    }
    
    func updateSavedPlayerData(player: Player) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedPlayer")
        fetchRequest.predicate = NSPredicate(format: "name = %@", player.getPlayerName())
        
        var returnedPlayer : SavedPlayer
        
        do {
            
            let results = try context.fetch(fetchRequest) as! [SavedPlayer]
            returnedPlayer = results[0]
            
            returnedPlayer.name = player.getPlayerName()
            returnedPlayer.power = Int16(player.displayPower())
            returnedPlayer.stndWins = Int16(player.getStndWinsLoses().0)
            returnedPlayer.stndLoses = Int16(player.getStndWinsLoses().1)
            returnedPlayer.sprWins = Int16(player.getSprWinsLoses().0)
            returnedPlayer.sprLoses = Int16(player.getSprWinsLoses().1)
            if player.getPlayerImage() != nil {
                returnedPlayer.playerImage = player.getPlayerImage()?.pngData() as Data?
            }
            
            do {
                try context.save()
                print("player data updated in Core Data")
            } catch let error as NSError {
                print("Could not save. \(error), \(error.localizedDescription)")
            }
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
        
        
    }
    
    func deletePlayerFromCoreData(playerToDelete: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedPlayer")
        fetchRequest.predicate = NSPredicate(format: "name = %@", playerToDelete)
        
        do {
            let results = try context.fetch(fetchRequest) as! [SavedPlayer]
            let returnedPlayer = results[0]
            context.delete(returnedPlayer)
            
            do {
                try context.save()
                print("Player succesfully deleted")
            } catch let error as NSError {
                print("Delete failed.\(error), \(error.localizedDescription)")
            }
            
        } catch let error as NSError {
            print("Failed to delete player. \(error), \(error.userInfo)")
        }
    }
    
    
    
}
