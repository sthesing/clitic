extern crate docopt;
extern crate libc;

use docopt::Docopt;
use std::io;
use std::io::BufRead;
use std::process;

const USAGE: &'static str = "
foo

Usage:
  foo [-] | [<input>...]
  foo (-h | --help)
  foo (-V | --version)

Options:
  -h, --help     Show this screen.
  -V, --version     Show version.
";

fn main() {
    let args = Docopt::new(USAGE)
                      .and_then(|dopt| dopt.parse())
                      .unwrap_or_else(|e| e.exit());
    //println!("{:?}", args);
    
    if args.get_bool("-V") {
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
}

// ##################################
// #       Helper functions         #
// ##################################

fn assemble_input_vector(args: &docopt::ArgvMap) -> Vec<String> {
    let mut input = Vec::new();
    // do we get input from stdin?
    let no_tty = unsafe { libc::isatty(libc::STDIN_FILENO as i32) } == 0;
    if args.get_bool("-") || no_tty {
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