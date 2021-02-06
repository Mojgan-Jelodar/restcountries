//
//  FileManager.swift
//  CountriesList
//
//  Created by m.jelodar on 1/30/21.
//

import Foundation

enum AppDirectories: String {
    case documents = "Documents"
    case inbox = "Inbox"
    case library = "Library"
    case temp = "tmp"
}

protocol AppDirectoryNames {

    func documentsDirectoryURL() -> URL

    func inboxDirectoryURL() -> URL

    func libraryDirectoryURL() -> URL

    func tempDirectoryURL() -> URL

    func getURL(for directory: AppDirectories) -> URL

    func buildFullPath(forFileName name: String, inDirectory directory: AppDirectories) -> URL

} // end protocol AppDirectoryNames

extension AppDirectoryNames {

    func documentsDirectoryURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    func inboxDirectoryURL() -> URL {
        return FileManager.default.urls(for: .documentDirectory,
                                        in: .userDomainMask)[0]
            .appendingPathComponent(AppDirectories.inbox.rawValue) // "Inbox")
    }

    func libraryDirectoryURL() -> URL {
        return FileManager.default.urls(for: FileManager.SearchPathDirectory.libraryDirectory, in: .userDomainMask).first!
    }

    func tempDirectoryURL() -> URL {
        return FileManager.default.temporaryDirectory
    }

    func getURL(for directory: AppDirectories) -> URL {
        switch directory {
        case .documents:
            return documentsDirectoryURL()
        case .inbox:
            return inboxDirectoryURL()
        case .library:
            return libraryDirectoryURL()
        case .temp:
            return tempDirectoryURL()
        }
    }

    func buildFullPath(forFileName name: String, inDirectory directory: AppDirectories) -> URL {
        return getURL(for: directory).appendingPathComponent(name)
    }
} // end extension AppDirectoryNames

protocol AppFileStatusChecking {
    func isWritable(file at: URL) -> Bool

    func isReadable(file at: URL) -> Bool

    func exists(file at: URL) -> Bool
}

extension AppFileStatusChecking {
    func isWritable(file at: URL) -> Bool {
        if FileManager.default.isWritableFile(atPath: at.path) {
            print(at.path)
            return true
        } else {
            print(at.path)
            return false
        }
    }

    func isReadable(file at: URL) -> Bool {
        if FileManager.default.isReadableFile(atPath: at.path) {
            print(at.path)
            return true
        } else {
            print(at.path)
            return false
        }
    }

    func exists(file at: URL) -> Bool {
        if FileManager.default.fileExists(atPath: at.path) {
            return true
        } else {
            return false
        }
    }
} // end extension AppFileStatusChecking

protocol AppFileSystemMetaData {
    @discardableResult
    func list(directory at: URL) -> Bool

    func attributes(ofFile atFullPath: URL) -> [FileAttributeKey: Any]
}

extension AppFileSystemMetaData {
    @discardableResult
    func list(directory at: URL) -> Bool {
        do {
            let listing = try FileManager.default.contentsOfDirectory(atPath: at.path)
            print("\n----------------------------")
            print("LISTING: \(at.path)")
            print("")
            for file in listing {
                print("File: \(file.debugDescription)")
            }
            print("")
            print("----------------------------\n")
        } catch let error {
            print("Error : \(error.localizedDescription)")
            return false
        }
        return true
    }

    func attributes(ofFile atFullPath: URL) -> [FileAttributeKey: Any] {
        do {
            return try FileManager.default.attributesOfItem(atPath: atFullPath.path)
        } catch let error {
            print(error.localizedDescription)
            return [:]
        }
    }
} // end extension AppFileSystemMetaData

protocol AppFileManipulation: AppDirectoryNames {
    func writeFile(containing: String, to path: AppDirectories, withName name: String) -> Bool

    func readFile(at path: AppDirectories, withName name: String) -> Data?

    func deleteFile(at path: AppDirectories, withName name: String) -> Bool

    func renameFile(at path: AppDirectories, with oldName: String, to newName: String) -> Bool

    func moveFile(withName name: String, inDirectory: AppDirectories, toDirectory directory: AppDirectories) -> Bool

    func copyFile(withName name: String, inDirectory: AppDirectories, toDirectory directory: AppDirectories) -> Bool

    func changeFileExtension(withName name: String, inDirectory: AppDirectories, toNewExtension newExtension: String) -> Bool
}

extension AppFileManipulation {
    func writeFile(containing: String, to path: AppDirectories, withName name: String) -> Bool {
        let filePath = getURL(for: path).path + "/" + name
        let rawData: Data? = containing.data(using: .utf8)
        return FileManager.default.createFile(atPath: filePath, contents: rawData, attributes: nil)
    }

    func readFile(at path: AppDirectories, withName name: String) -> Data? {
        let filePath = getURL(for: path).path + "/" + name
        let fileContents = FileManager.default.contents(atPath: filePath)
        return fileContents
    }

    func deleteFile(at path: AppDirectories, withName name: String) -> Bool {
        let filePath = buildFullPath(forFileName: name, inDirectory: path)
        do {
            try FileManager.default.removeItem(at: filePath)
            print("\nFile deleted.\n")
        } catch let error {
            print(error.localizedDescription)
            return false
        }
        return true
    }

    func renameFile(at path: AppDirectories, with oldName: String, to newName: String) -> Bool {
        let oldPath = getURL(for: path).appendingPathComponent(oldName)
        let newPath = getURL(for: path).appendingPathComponent(newName)
        do {
            try FileManager.default.moveItem(at: oldPath, to: newPath)
        } catch {
            return false
        }
        return true
    }

    func moveFile(withName name: String, inDirectory: AppDirectories, toDirectory directory: AppDirectories) -> Bool {
        let originURL = buildFullPath(forFileName: name, inDirectory: inDirectory)
        let destinationURL = buildFullPath(forFileName: name, inDirectory: directory)
        do {
            try FileManager.default.moveItem(at: originURL, to: destinationURL)
        } catch {
            return false
        }
        return true
    }

    func copyFile(withName name: String, inDirectory: AppDirectories, toDirectory directory: AppDirectories) -> Bool {
        let originURL = buildFullPath(forFileName: name, inDirectory: inDirectory)
        let destinationURL = buildFullPath(forFileName: name, inDirectory: directory)
        do {
            try FileManager.default.copyItem(at: originURL, to: destinationURL)
        } catch {
            return false
        }
        return true
    }

    func changeFileExtension(withName name: String, inDirectory: AppDirectories, toNewExtension newExtension: String) -> Bool {
        var newFileName = NSString(string: name)
        newFileName = newFileName.deletingPathExtension as NSString
        newFileName = (newFileName.appendingPathExtension(newExtension) as NSString?)!
        let finalFileName: String =  String(newFileName)

        let originURL = buildFullPath(forFileName: name, inDirectory: inDirectory)
        let destinationURL = buildFullPath(forFileName: finalFileName, inDirectory: inDirectory)
        do {
            try FileManager.default.moveItem(at: originURL, to: destinationURL)
        } catch {
            return false
        }
        return true
    }
} // end extension AppFileManipulation

struct AppFileSystemDirectory: AppFileManipulation, AppFileStatusChecking, AppFileSystemMetaData {

    let workingDirectory: AppDirectories

    init(using directory: AppDirectories) {
        self.workingDirectory = directory
    }

    func writeFile(containing text: String, withName name: String) -> Bool {
        return writeFile(containing: text, to: workingDirectory, withName: name)
    }

    func readFile(withName name: String) -> Data? {
        return readFile(at: workingDirectory, withName: name)
    }

    func deleteFile(withName name: String) -> Bool {
        return deleteFile(at: workingDirectory, withName: name)
    }

    func showAttributes(forFile named: String) {
        let fullPath = buildFullPath(forFileName: named, inDirectory: workingDirectory)
        let fileAttributes = attributes(ofFile: fullPath)
        for attribute in fileAttributes {
            print(attribute)
        }
    }

    func list() {
        list(directory: getURL(for: workingDirectory))
    }
}
