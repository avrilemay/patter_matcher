# PM_11 - Pattern Matcher in Lisp

## Overview

This project implements a pattern matcher in Lisp, designed as part of the Algorithmics and Data Structures course. The system matches user inputs against predefined patterns to generate corresponding responses. It simulates an interaction with a fictional character, in this case, a politician named Fabien Roussel.

## Project Structure

The project consists of two main files:

- **PM_11.lisp**: This is the core file containing the main logic of the pattern matcher, including all the necessary functions.
- **PM_11_data.lisp**: This file contains global variables, patterns, and responses used by the pattern matcher.

### Key Functions

- **Eliza**: The main function that initializes and drives the pattern matcher. It resets variables and results at each iteration, processes user inputs, and calls other functions to match patterns and generate responses.
- **read-input**: Reads a user's input, splits it into words, and converts those words into symbols for processing.
- **split-by-one-space**: Splits a string into words using spaces as delimiters, and is utilized by `read-input`.
- **match**: The core function that matches user inputs against patterns, handling various cases including lists, wildcard symbols (`*`), and specific pattern conditions.
- **put**: Assigns values to properties in a global list, used mainly in the pattern matching process.
- **$**: A helper function used within `match` to test input words against variables and update global variables if needed.
- **answer**: Constructs the response based on the matched pattern, storing results in a list for a cleaner output.
- **imprimer-liste**: Prints the elements of a list in a user-friendly format without adding unnecessary line breaks.
- **print-output**: Manages the output printing process by calling `print-with-joker` to handle wildcard characters.
- **print-with-joker**: Handles the special wildcard characters in the output, customizing the response based on user inputs.
- **butfirst**: Returns an atom with the name of the first argument minus the first character, used to process pattern elements.
- **+z**: Appends the letter "z" to the end of a word, used for generating specific outputs.
- **appartient**: Checks if a word belongs to a given list of words and returns the word if it does.
- **nompropre**: Checks if a word is a proper noun by verifying if it starts with a capital letter.

## Usage

To use the pattern matcher:

1. Load the `PM_11.lisp` file in a Lisp environment.
2. Start the pattern matcher by calling the `Eliza` function with the `patterns` as an argument: `(Eliza patterns)`.
3. The system will simulate a conversation based on the predefined patterns.

## Example Interaction

Here’s an example of an interaction with the system:

```lisp
Utilisateur: Bonjour Monsieur Roussel.
Fabien Roussel: Bonjour!
Utilisateur: Comment ça va ?
Fabien Roussel: Je vais très bien. Merci. Et vous?
```

The conversation can continue for multiple exchanges, simulating a realistic dialogue.

## Limitations

The pattern matcher has some limitations:

- It is case-sensitive, so inputs must match the case used in the patterns.
- Punctuation marks like periods or question marks immediately following a word can prevent the pattern from matching correctly.
- The system cannot handle numbers or special characters in the patterns or outputs.

## License

This project was developed as part of the Algorithmics and Data Structures course and is provided for educational purposes.

## Author

**Avrile Floro**


