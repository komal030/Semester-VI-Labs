'''python3 sepmap.py|sort|python3 sepred.py'''
#!/usr/bin/env python
import sys

def read_input(file):
    for line in file:
        # split the line into words
        yield line.split()

def main(separator='\t'):
    # Open the file heart.txt for reading
    with open('HR.txt', 'r') as file:
        # input comes from the heart.txt file
        data = read_input(file)
        for words in data:
            # write the results to STDOUT (standard output);
            # what we output here will be the input for the
            # Reduce step, i.e. the input for reducer.py# tab-delimited; the trivial word count is 1
            for word in words:
                print('%s%s%d' % (word, separator, 1))

if __name__ == "__main__":
    main()
