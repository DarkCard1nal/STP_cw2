# STP_cw2

_Created for the course "Stack of programming technologies" V. N. Karazin Kharkiv National University_

Ruby 3.3.5 module ArrayAverageValue and class ShoppingCart.

---

# README.md

## Ruby Multithreading Projects

This repository contains two Ruby programs that demonstrate multithreading capabilities in different contexts:

1. **Processing and modifying numbers in files using threads.**
2. **Performing simultaneous HTTP requests using threads.**

---

## Task 1: Square Numbers in Files

### Overview

The program reads numbers from an input file, replaces each number with its square, and writes the result to an output file. Multithreading is used to process the numbers efficiently in parallel. The numbers can be in any structure or located anywhere in the input file.

### File Structure

- **Directory:** `task1`
- **Main file:** `program.rb`
- **Support module:** `square_number.rb`
- **RSpec tests:** `square_number_spec.rb`

### Usage

Run the program using the following format:

```bash
ruby program.rb path/to/input_file.txt path/to/output_file.txt
```

If paths are not provided, default file paths will be used (`input.txt` and `output.txt`).

### Workflow

1. **Input file reading:** Extracts all numbers from the input file.
2. **Square computation:** Each number is squared using a multithreaded approach (`Thread.new`).
3. **Output file writing:** The input file's content is read again, and each number is replaced with its square before saving to the output file.

### Example

#### Input (`input.txt`):

```
2 3 4
```

#### Output (`output.txt`):

```
4 9 16
```

### Features

- **Error handling:** Ensures proper file handling and provides error messages if the input or output file is inaccessible.
- **Multithreading:** Speeds up computation of squares for large datasets.

### Testing

Run the RSpec tests in `square_number_spec.rb` to validate functionality:

```bash
rspec spec/square_number_spec.rb
```

---

## Task 2: HTTP Requests Using Threads

### Overview

This program performs multiple HTTP GET requests in parallel using threads, demonstrating how multithreading can optimize network operations.

### File Structure

- **Directory:** `task2`
- **Main file:** `program.rb`

### Usage

Run the program with:

```bash
ruby program.rb
```

### Workflow

1. **URLs:** A predefined array of URLs (`urls`) is used as input.
2. **Parallel HTTP requests:** Each URL is processed in a separate thread using `Net::HTTP` to fetch the response.
3. **Output:** The program prints the HTTP status code and message for each request.

### Example Output

The order of results may vary depending on which thread finishes first:

```
Fetched https://www.google.com: 200 OK
Fetched https://github.com: 200 OK
Fetched https://discord.com: 200 OK
Fetched https://www.youtube.com: 200 OK
All requests completed!
```

### Features

- **Multithreading:** Executes all HTTP requests in parallel, reducing total execution time.
- **Error handling:** Catches and logs any network-related errors.

---
