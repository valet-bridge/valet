import os
from urlextract import URLExtract

def extract_uris_from_file(file_path):
    extractor = URLExtract()
    unique_uris = set()

    with open(file_path, 'r') as file:
        for line in file:
            fields = line.strip().split('|')
            for field in fields:
                uris = extractor.find_urls(field)
                unique_uris.update(uris)

    return sorted(unique_uris)

def process_directory(base_dir):
    for root, dirs, files in os.walk(base_dir):
        # Filter directories to only those with exactly six digits in the name
        dirs[:] = [d for d in dirs if d.isdigit() and len(d) == 6]
        
        # Process each .lin file in the filtered directories
        for file in files:
            if file.endswith('.lin'):
                file_path = os.path.join(root, file)
                uris = extract_uris_from_file(file_path)

                if uris:
                    # Print the base name of the file and the sorted URIs
                    print(os.path.basename(file))
                    for uri in uris:
                        print(uri)
                    print()  # Empty line after each file

if __name__ == "__main__":
    base_dir = '../../../../../../../bboD'  # Replace with your directory path
    process_directory(base_dir)

