# There's actually nothing to build, but I hate deploying shit by hand

install_files=odt2txt oodump
install_dir=${HOME}/bin

all: run_tests install

clean:
	@rm -f *~ *.bak *.orig *.pyc

run_tests:
	@python test_python_dependencies

install:
	mkdir -p ${install_dir}
	install -m744 ${install_files} ${install_dir}
	@echo "You should make sure that ${install_dir} is in your PATH"
