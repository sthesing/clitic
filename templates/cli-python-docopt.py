"""foo

Usage:
    foo [options] [-] | [options] [<input>...]  
    foo -h | --help
    foo -V | --version

Options:
    -t, --test    Test
"""
import sys
from docopt import docopt

__version__ = '0.1.0'

def read_stdin():
    inp = []
    for line in sys.stdin:
        inp.append(line.strip("\n"))
    return inp

if __name__ == "__main__":
    arguments = docopt(__doc__, version='foo ' + __version__)
    #print("Arguments:", arguments)       
    if arguments['-V']:
        print('foo', __version__)
        exit()
    
    if not sys.stdin.isatty() or arguments['-']:
        for arg in read_stdin():
            arguments['<input>'].append(arg)
    
    ################################################################
    
    # The rest of main is to satisfy the clitic-tests, it can be safely 
    # removed 
    
    if arguments['<input>']:
        for a in arguments['<input>']:
            print(a)
    else:
        print("Hello World!")
    
    if arguments['--test']:
        print("Test flag set.")