extern crate clap;
extern crate atty;

use clap::{App, Arg, ArgMatches};
use atty::Stream;
use std::io::{self, BufRead};


// ##################################
// #       Helper functions         #
// ##################################

fn assemble_input_vector(matches: &ArgMatches) -> Vec<String> {
    let mut input = Vec::new();
    // do we get input from stdin?
    //if args.get_bool("-") || atty::isnt(Stream::Stdin) {
    if atty::isnt(Stream::Stdin) {
        input = read_stdin();
    } else {
        // construct a vector containin proper strings from args.get_vec("<input>")
        if let Some(arg_input) = matches.values_of("input") {
            //input = arg_input.collect();
            for arg in arg_input {
                input.push(arg.to_string());
            }
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

fn main() {
    let matches = App::new(env!("CARGO_PKG_NAME"))
            .version(env!("CARGO_PKG_VERSION"))
            // arguments can be defined verbosely
            .arg(Arg::with_name("test")
                .short("t")
                .long("test")
                .help("Test")
                .required(false))
            .arg(Arg::with_name("input")
                .multiple(true))
            .get_matches();
    
    let input = assemble_input_vector(&matches);
    
     //The rest of main is to satisfy the clitic-tests, it can be safely 
     //removed    
    if input.is_empty() {
        println!("Hello World!");
    } else {
        for arg in input {
            println!("{}", arg);
        }
    }
    
    if matches.is_present("test") {
        println!("Test flag set.");
    }
}
