CSV Folder Structure Generator
Description
The CSV Folder Structure Generator is a Zsh script designed to create a detailed CSV file that maps out the structure of a specified directory. It includes subfolder names and file names, with the option to filter by file extensions and include hidden files.

Features
Generates a CSV file detailing the folder structure.
Allows filtering by specific file extensions.
Option to include or exclude hidden files.
Inserts a blank line between each directory's contents for better readability.
Usage
Clone the repository:

sh
Copia codice
git clone https://github.com/Fabiodalez/csv-folder-structure-generator.git
cd csv-folder-structure-generator
Make the script executable:

sh
Copia codice
chmod +x create_folder_structure.sh
Run the script:

sh
Copia codice
./create_folder_structure.sh
Follow the prompts:

Choose whether to create the CSV file in the current folder or specify another folder.
Enter the file extensions to filter by (e.g., jpg mov). Leave empty to include all files.
Choose whether to include hidden files.
Example
When you run the script, it will prompt you for input as follows:

vbnet
Copia codice
Do you want to create the CSV file in the current folder? (y/n)
Enter the path of the folder (leave empty to use the current folder):
Enter file extensions to filter by (e.g., jpg mov), or leave empty to include all files:
Do you want to include hidden files? (y/n)
After providing the necessary input, the script will generate a folder_structure.csv file in the specified location, detailing the folder structure.

CSV File Format
The generated CSV file will have the following columns:

Main Folder Name: The name of the main directory.
Subfolder Name: The relative path of the subfolder.
File Name: The name of the file.
Example:

arduino
Copia codice
Main Folder Name,Subfolder Name,File Name
main_folder,subfolder1,file1.jpg
main_folder,subfolder1,file2.mov

main_folder,subfolder2,file3.jpg
main_folder,subfolder2,file4.mov
License
This project is licensed under the Gpl License. See the LICENSE file for details.
