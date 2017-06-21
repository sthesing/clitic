.PHONY: python python3 python-docopts rust test clean

test-all: python python3 python-docopts rust

python: export cmd = "python cli-python.py"
python: export template = "Python with argparse"
python:
	@$(MAKE) --no-print-directory test 

python3: export cmd = "python3 cli-python.py"
python3: export template = "Python3 with argparse"
python3:
	@$(MAKE) --no-print-directory test 

python-docopts: export cmd = "python3 cli-python-docopt.py"
python-docopts: export template = "Python3 with docopt"
python-docopts:
	@$(MAKE) --no-print-directory test 

rust: export cmd = "./rust/target/debug/foo"
rust: export template = "Rust with docopt"
rust:
	# Build binary of Rust template
	@$(MAKE) -C templates/rust build
	@echo ""
	@$(MAKE) --no-print-directory test 

test:
	@echo $(cmd) > tmpcmd
	# Running test for $(template)
	@bats tests/clitic.bats
	@rm tmpcmd

clean:
	# Cleaning up after interrupted run.
	@rm tmpcmd