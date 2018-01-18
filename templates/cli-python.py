import argparse
import sys

__version__ = '0.1.0'

if __name__ == "__main__":
    parser = argparse.ArgumentParser(prog='foo')
    parser.add_argument('-V', '--version', action='version', 
        version='%(prog)s '+ __version__)

    if sys.stdin.isatty():
        # Interactive shell 
        input_arg_default = None
    else:
        # Piped
        input_arg_default = sys.stdin
    parser.add_argument(
        'input',
        nargs='*',
        default = input_arg_default,
        help='Helpful text'
        )
    parser.add_argument('-t', '--test', action="store_true",
        help='Helpful text for test.')
    args = parser.parse_args()
    # If input came from a pipe, it's a TextIOWrapper,
    # that has to be iterated over. To have input from
    # both cases iterable, let's make a list of what
    # ever input we have and iterate over that.

    input = []
    if args.input == ['-']: # traditional stdin switch
        args.input = []     # we don't want it any longer
        for line in sys.stdin:
            input.append(line.rstrip())
    
    if not input_arg_default:
        input += args.input
    else:
        input += list(args.input)
    
    ################################################################
    
    # The rest of main is to satisfy the clitic-tests, it can be safely 
    # removed   
    
    if not input:
        print("Hello World!")
    else:
        for item in input:
            # In case our arguments came from a pipe via stdin,
            # they each end with a line break. We have to strip 
            # those away.
            print(item.rstrip())
    
    if args.test:
        print("Test flag set.")