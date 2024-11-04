#! /usr/bin/python3.6

# import packages directly below this line
# for example, you could import the package 'os'
import os
from sklearn.feature_selection import chi2

# import necessary functions and modules here

def main():
    # Step 1: get the arguments

    # Step 2: get corpus and classifications from get_reviews()

    # Step 3: get terms from corpus_terms()

    # Step 4: get tfidf_scores from tfidf()

    # Keep the code below untouched (or static)
    chi2scores = chi2(tfidf_scores, classifications)[0]
    chi2scores = zip(terms, chi2scores)
    print("Great words to use as features for a review classifier:")
    words = [word for word in sorted(chi2scores, key=lambda x:x[1], reverse=True)[:10]]
    for idx, word in enumerate(words, 1):
        print(f'{idx}. {word[0]} ({word[1]:.3f})')
    
if __name__ == "__main__":
    main()
