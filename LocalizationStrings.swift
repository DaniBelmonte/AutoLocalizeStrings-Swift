import Foundation

/// Estructura que representa una fila de datos de localización.
struct LocalizationRow {
    let key: String
    let values: [String]
}

/// Lee un archivo TSV y devuelve las filas de localización y un array de idiomas.
///
/// - Parámetro filePath: La ruta del archivo TSV.
/// - Devuelve: Una tupla opcional que contiene las filas de localización y un array de idiomas.
///            Si hay un error al leer el archivo, devuelve nil.
func readLocalizationTSV(filePath: String) -> ([LocalizationRow], [String])? {
    do {
        let content = try String(contentsOfFile: filePath)
        let lines = content.components(separatedBy: .newlines)
        var localizationRows: [LocalizationRow] = []
        
        let languages = lines[0].components(separatedBy: "\t").dropFirst()
        
        for i in 1..<lines.count {
            let columns = lines[i].components(separatedBy: "\t")
            guard let key = columns.first else { continue }
            let values = Array(columns.dropFirst())
            let localizationRow = LocalizationRow(key: key, values: values.map { $0.trimmingCharacters(in: .whitespacesAndNewlines) })
            localizationRows.append(localizationRow)
        }
        
        return (localizationRows, Array(languages))
        
    } catch {
        print("Error al leer el archivo TSV: \(error)")
        return nil
    }
}

/// Genera archivos de localización .strings para cada idioma a partir de las filas de localización proporcionadas.
///
/// - Parámetro localizationRows: Las filas de localización.
/// - Parámetro languages: Array de idiomas
/// - Parámetro outputDirectory: Carpeta de salida donde se generarán los archivos de localización.
func generateLocalizationFiles(localizationRows: [LocalizationRow], languages: [String], outputDirectory: String) {
    let resourcesDirectory = "\(outputDirectory)/Resources"
    do {
        try FileManager.default.createDirectory(atPath: resourcesDirectory, withIntermediateDirectories: true, attributes: nil)
    } catch {
        print("Error al crear la carpeta de output: \(error)")
        return
    }
    
    for (index, language) in languages.enumerated() {
        var stringsContent = ""
        for row in localizationRows {
            if row.values.count > index {
                let value = row.values[index].replacingOccurrences(of: "\"", with: "\\\"")
                stringsContent += "\"\(row.key)\" = \"\(value)\";\n"
            }
        }
        
        // Si no es necesaria la carpeta para tu proyecto puedes modificar el código
        let languageFolder = "\(resourcesDirectory)/\(language).lproj"
        do {
            try FileManager.default.createDirectory(atPath: languageFolder, withIntermediateDirectories: true, attributes: nil)
        } catch {
            print("Error al crear la carpeta de idioma: \(error)")
            continue
        }
        
        // Esta ruta de salida puede ser modificada según las necesidades
        let outputPath = "\(languageFolder)/Localizable.strings"
        do {
            try stringsContent.write(toFile: outputPath, atomically: true, encoding: .utf8)
            print("Archivo de localizable generado para \(language) en \(outputPath)")
        } catch {
            print("Error al escribir el archivo para el idioma \(language): \(error)")
        }
    }
}

/// Función principal que ejecuta el script.
func main() {
    let arguments = CommandLine.arguments
    guard arguments.count == 3 else {
        print("Usar de la siguiente manera: \(arguments[0]) <archivo TSV> <directorio de salida>")
        return
    }
    
    let tsvFilePath = arguments[1]
    let outputDirectory = arguments[2]
    
    if let (localizationRows, languages) = readLocalizationTSV(filePath: tsvFilePath) {
        generateLocalizationFiles(localizationRows: localizationRows, languages: languages, outputDirectory: outputDirectory)
    } else {
        print("Error al leer las filas del archivo TSV.")
    }
}

// Descomenta la siguiente línea para llamar a la función principal y ejecutar el script
//main()
