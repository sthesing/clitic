extern crate docopt;
extern crate atty;

use atty::Stream;
use docopt::Docopt;
use std::io;
use std::io::BufRead;
use std::process;

// ##################################
// #       Helper functions         #
// ##################################

fn assemble_input_vector(args: &docopt::ArgvMap) -> Vec<String> {
    let mut input = Vec::new();
    // do we get input from stdin?
    if args.get_bool("-") || atty::isnt(Stream::Stdin) {
        input = read_stdin();
    } else {
    // construct a vector containin proper strings from args.get_vec("<input>")
        for arg in args.get_vec("<input>") {
            input.push(arg.to_string());
        }
    }
    input
}

fn read_stdin() -> Vec<String> {
    let mut input = Vec::new();
    let stdin = io::stdin();
    for line in stdin.lock().lines() {
        input.push(line.unwrap());
    }
    input
}

// ##################################
// #         Program Logic          #
// ##################################

const USAGE: &'static str = "foo

Usage:
  foo [options] [-] | [options] [<input>...]
  foo -h | --help
  foo -V | --version

Options:
    -t, --test    Test
";

fn main() {
    let args = Docopt::new(USAGE)
                      .and_then(|dopt| dopt.parse())
                      .unwrap_or_else(|e| e.exit());
    
    if args.get_bool("-h") {
        print!("{}", USAGE);
        process::exit(0);
    }
    
    if args.get_bool("-V") || args.get_bool("--version") {
        println!("{} {}", env!("CARGO_PKG_NAME"), env!("CARGO_PKG_VERSION"));
        process::exit(0);
    }
    
    // You can conveniently access values with `get_{bool,count,str,vec}`
    // functions. If the key doesn't exist (or if, e.g., you use `get_str` on
    // a switch), then a sensible default value is returned.
    
    // To have input working from command line as well as from stdin,
    // we assemble it to a Vec<String>
    // Use this instead of args.get_vec("<input>")
    let input = assemble_input_vector(&args);
    
    // The rest of main is to satisfy the clitic-tests, it can be safely 
    // removed    
    if input.is_empty() {
        println!("Hello World!");
    } else {
        for arg in input {
            println!("{}", arg);
        }
    }
    
    if args.get_bool("--test") {
        println!("Test flag set.");
    }
}

