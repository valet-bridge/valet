import nltk
from names_dataset import NameDataset
from rapidfuzz import fuzz
import time

# Download required NLTK datasets
nltk.download('wordnet')
from nltk.corpus import wordnet

# Load English word dataset
common_words = set(word.name().split('.')[0] for word in wordnet.all_synsets())

# Load and clean input
with open("xx2", "r", encoding="utf-8") as f:
    raw_names = [line.strip().lower() for line in f if line.strip()]
unique_names = sorted(set(raw_names))

# Initialize names-dataset
nd = NameDataset()

# Function to check if a name is a known surname using fuzzy matching
def is_known_surname(name, threshold=90):
    name_cap = name.capitalize()
    if name_cap in nd.last_names:
        return True
    for known_name in nd.last_names:
        if fuzz.ratio(name_cap, known_name) >= threshold:
            return True
    return False

# Process in batches of 20
batch_size = 20
total = len(unique_names)

for i in range(0, total, batch_size):
    batch = unique_names[i:i+batch_size]

    classified = []
    manual_review = []
    overlapping = []

    for name in batch:
        name_cap = name.capitalize()
        is_word = name in common_words
        is_surname = is_known_surname(name)

        # Single decision point with multiple category support
        if is_word and is_surname:
            overlapping.append(name_cap)
        elif is_surname:
            classified.append((name_cap, "Known Surname"))
        elif is_word:
            classified.append((name_cap, "Common Word"))
        else:
            manual_review.append(name_cap)

    # Write classified names to file
    with open("validated_names.txt", "a", encoding="utf-8") as f:
        for name, label in classified:
            f.write(f"{name}\t{label}\n")
        f.flush()

    # Write overlapping names to separate file
    with open("overlapping_names.txt", "a", encoding="utf-8") as f:
        for name in overlapping:
            f.write(f"{name}\tCommon Word & Known Surname\n")
        f.flush()

    # Write names needing manual review to file
    with open("manual_review.txt", "a", encoding="utf-8") as f:
        for name in manual_review:
            f.write(f"{name}\n")
        f.flush()

    # Print progress
    processed = min(i + batch_size, total)
    print(f"Processed {processed}/{total} names ({(processed / total) * 100:.2f}%)")

print("✅ Done. All batches processed and written to output files.")

