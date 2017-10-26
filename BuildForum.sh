#!/bin/bash
#    @author Morten Terhart
#    * Creation Date: 26.10.17
#
#    * Script for automatic compilation of Java source files and reporting the results
#    * Includes a lot of safety checks for requirements

# Define script constants
usage_message="usage: ./${0##*/} [--help]";
webapp_name="Forum-INF16B";
exit_status=0;

# If standard output (file descriptor 1) is directed to a terminal
# activate colored output
if [ -t 1 ]; then
	red_color=$'\e[91m';
	green_color=$'\e[92m';
	clear_color=$'\e[0m';
fi

# Function to display a fancy banner at startup
function launchBanner() {
 	printf "\n%s\n" "${green_color}_______   ______   .______       __    __  .___  ___.        __  .__   __.  _______ __     __   .______   ";
	printf "%s\n"   "|   ____| /  __  \  |   _  \     |  |  |  | |   \/   |       |  | |  \ |  | |   ____/_ |   / /   |   _  \  ";
	printf "%s\n"   "|  |__   |  |  |  | |  |_)  |    |  |  |  | |  \  /  |       |  | |   \|  | |  |__   | |  / /_   |  |_)  | ";
	printf "%s\n"   "|   __|  |  |  |  | |      /     |  |  |  | |  |\/|  |       |  | |  . \`  | |   __|  | | | '_ \  |   _  <  ";
	printf "%s\n"   "|  |     |  \`--'  | |  |\  \----.|  \`--'  | |  |  |  |       |  | |  |\   | |  |     | | | (_) | |  |_)  | ";
	printf "%s\n\n" "|__|      \______/  | _| \`._____| \______/  |__|  |__|       |__| |__| \__| |__|     |_|  \___/  |______/  ${clear_color}";
}

# Function to output a uniform error message
function error() {
	printf -- "${red_color}ERROR: %s${clear_color}\n" "$*" >&2;
}

case "$1" in
	--help | -h)
		printf "%s\n" "${usage_message}";
		exit 0;
esac

# If the script catches an interrupt signal, exit directly
trap "printf '\n[%s]: Aborted compilation by signal SIGINT(2)\n' '${webapp_name}';
      exit 2;"  SIGINT;

printf "[%s]: Checking if current directory is the project's root directory ..." "${webapp_name}";
if [ -d "WEB-INF" ]; then
	printf " successful!\n";
	printf "[%s]: Checking if WEB-INF/classes is existent ..." "${webapp_name}";
	if [ -d "WEB-INF/classes" ]; then
		printf " existent!\n";
	else
		printf " not existent!\n";
		printf "[%s]: Creating new directory 'WEB-INF/classes' for bytecode.\n" "${webapp_name}";
		mkdir -p WEB-INF/classes;
	fi

	launchBanner;

	printf "[%s]: Switching to directory 'WEB-INF'.\n" "${webapp_name}";
	cd WEB-INF;

	printf "_______________________________________________\n\n";

	printf "[%s]: Looking after Java sources in 'WEB-INF/src' ..." "${webapp_name}";
	if [ -f "src/User.java" ]; then
		printf " found!\n\n";

		declare -a erroneous_files=();
		printf "[%s]: Compiling Java sources in 'WEB-INF/src'.\n" "${webapp_name}";
		for java_source in src/*.java
		do
			printf "[%s]: Compiling %s ...\n" "${webapp_name}" "${java_source}";
			javac -cp "lib/*:classes" -encoding "UTF-8" -d classes -Xlint:static "${java_source}";
			if [ $? -ne 0 ]; then
				erroneous_files+=("${java_source}");
				exit_status=1;
			else
				printf -- "  ${green_color}> No errors${clear_color}\n";
			fi
		done

		printf "_______________________________________________\n\n";
		if [ "${exit_status}" -ne 0 ]; then
			error "The following files had compiling issues:";
			printf "  ${red_color}> %s${clear_color}\n" "${erroneous_files[@]}" >&2;
			error "Check them again and fix the errors!";
		else
			printf "[%s]: No compilation errors were detected.\n" "${webapp_name}";
		fi

		printf "\n[%s]: The Java bytecode was moved to 'WEB-INF/classes'.\n" "${webapp_name}";
	else
		printf " not found!\n\n";
		printf "[%s]: Could not find any java files in 'WEB-INF/src'.\n" "${webapp_name}";
		printf "[%s]: Make sure they are inside 'WEB-INF/src'.\n" "${webapp_name}";
		error "No Java source files found";
		exit_status=2;
	fi
else
	printf " failed!\n";
	printf "[%s]: Switch to the project's directory %s first to execute this script:\n" "${webapp_name}" "${0%/*}";
	printf "   $ cd %s\n" "${0%/*}";
	error "Executing from wrong directory";
	exit_status=2;
fi

exit "${exit_status}";
