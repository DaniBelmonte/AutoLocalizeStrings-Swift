# AutoLocalizeStrings
 
### Preparación:

- Este script se ejecuta desde la consola.
- Deberás tener un archivo .tsv con el siguiente formato:

```bash
Key     en          es          fr
hello   Hello       Hola        Bonjour
world   World       Mundo       Monde
```

### Descarga del código:

- Clona el repositorio que contiene este código o descarga el repositorio.

### Incluir en el proyecto:

- Copia el archivo Swift (`LocalizationStrings.swift`) en el directorio raíz de tu proyecto Xcode.

### Ejecutar del script:

1. Abre una terminal en la carpeta donde tengas el archivo Swift.
2. Ejecuta el script desde la terminal con el siguiente comando:
   ```bash
   swift LocalizationStrings.swift <archivo TSV> <directorio de salida>
   ```
   - Reemplaza `<archivo TSV>` con la ruta al archivo TSV que contiene los datos de localización.
   - Reemplaza `<directorio de salida>` con el directorio donde quieres que se generen los archivos localizables.

Ejemplo para el directorio actual:
```bash
swift LocalizationStrings.swift archivo.tsv .
```

### Resultado:

- El script leerá el archivo TSV proporcionado y generará archivos de localización `.strings` para cada idioma del archivo TSV.
- Los archivos de localización se generarán en el directorio especificado como `<directorio de salida>`.
- Cada archivo `.strings` contendrá las claves y valores de localización correspondientes al idioma específico.
