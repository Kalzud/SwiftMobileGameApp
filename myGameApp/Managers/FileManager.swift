//
//  FileManager.swift
//  myGameApp
//
//  Created by Emmanuel Uduma
//  @00566883
//
//  This class controls the file.io for this application it
//  handles all the reading and writing to the file and
//  operates as a singleton (only a single instance of it is used through out the game)

//........Import Statements ...................
import Foundation


class FileManager {
    static let shared = FileManager()  // Singleton instance
    private let fileName = "myFile.txt" // create file
    
    
    //==========================================================================================
    // Computed property to get the file URL
    var fileUrl: URL {
        // Get the URL of the document directory in the user's domain
        let docDirUrl = Foundation.FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        // Append the file name to the document directory URL to create the file URL
        return docDirUrl.appendingPathComponent(fileName)
    }
    
    //==========================================================================================
    // Method to write text to the file
    func writeToFile(_ text: String) {
        do {
            let fileHandle = try FileHandle(forWritingTo: fileUrl) // Open a file handle for writing to the file at fileUrl
            fileHandle.seekToEndOfFile() // Move the file handle to the end of the file
            fileHandle.write(text.data(using: .utf8)!) // Convert the text string to data using UTF-8 encoding and write it to the file
            fileHandle.closeFile() // Close the file handle after writing
        } catch {
            print("Error writing to file:", error) // Handle any errors that occur during file writing
        }
    }

    //==========================================================================================
    // Method to read file contents
    func readFileContents() -> String? {
        do {
            let fileContents = try String(contentsOf: fileUrl, encoding: .utf8) // Read the contents of the file at fileUrl using UTF-8 encoding
            return fileContents // Return the file contents as a String
        } catch {
            print("Error reading file:", error) // Handle any errors that occur during file reading
            return nil // Return nil to indicate that an error occurred
        }
    }
    
    //==================================================================================================================
    // Method to delete the file
    func deleteFile() {
        let fileManager = Foundation.FileManager.default  // Get the default file manager instance
        
        do {
            try fileManager.removeItem(at: fileUrl)  // Attempt to remove the file at the specified URL
            print("File deleted successfully.")  // If successful, print a success message
        } catch {
            print("Error deleting file:", error)  // If an error occurs during file deletion, print the error message
        }
    }

    //=====================================================================================================================
    // Method to clear the contents of the file
    func clearFile() {
        do {
            let fileHandle = try FileHandle(forWritingTo: fileUrl)  // Attempt to create a file handle for writing to the file URL
            fileHandle.truncateFile(atOffset: 0)  // Truncate the file to clear its contents
            fileHandle.closeFile()  // Close the file handle after truncating the file
            print("File contents cleared successfully.")  // Print a success message after clearing the file contents
        } catch {
            print("Error clearing file contents:", error)  // Print an error message if an error occurs during file clearing
        }
    }
//................................................END OF CLASS.............................................................
}
