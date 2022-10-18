# README

## Introduction

In this assignment you will be writing wrapper programs around an external program.

- Due: End-of-lab
- Deliverables: Commit and push to Github. Submit to Gradescope.

## Notes on using exec()

The exec() system can be a bit tricky to use. There are multiple (!) different versions of this system call, and the version we'll be using is `execv` (notice the "v" at the end).

For example, to run the `ls` command, this is what you need to do: first create an array of arguments, and then do the execv() system call:

    char* args[] = { "ls", "", NULL };
    int exec_ret = execv("/usr/bin/ls", args);
    if(exec_ret == -1) {
        perror("Problem with exec");
    }

What the first line does is create an array of arguments (BTW, this is the array that the main function will receive).

The 0th element is the name of the program ("ls"), and then, the array is terminated with `NULL`. It is important that
we are passing one argument, the array contains two.

The second line does the actual system call. The first argument is where to find the file that contains the program.
It is important to provide the full path to the program (i.e. `/usr/bin/ls` instead of `ls`), because otherwise exec
may not be able to find the program.

Next, we check if the return value was -1. If it is, there was an error, so we use a special version of puts called
perror which will also print the reason for the system call failing. It is important that you check for the return value
since it is critial for debugging issues with exec().

Note that the return value of exec is *not* the same as the exit status of the program. To get the exit status, you need
to use the `wait` system call.

As another example, let's say you want to provide two additional arguments: "-1" (one line per file) and "-t" (sort by
time). This is what you would do instead:

    char* args[] = { "ls", "-1", "-t", NULL };
    int exec_ret = execv("/usr/bin/ls", args);
    if(exec_ret == -1) {
        perror("Problem with exec");
    }

## Assignment Details

There are two parts to this assignment.

### Part A

#### Background

In this part, you will use the `grep` command. This command searches for patterns (called "regular expressions") in a
file. If the "-q" option is given, it will search for the pattern, and exit with status 0 if the pattern was found, but
non-zero if the pattern was not found.

For example,

    $ grep -q fox tests/file1.txt

Will exit with status 0 because the file contains the word `fox`.

On the other hand,

    $ grep -q deer tests/file1.txt

Will exit with status 1 because the word `deer` does not exist in the file.


#### The Task

Write a program that will take a command line argument, which is the word to search for. First check if you have one
argument (`argc == 2`). If not, then print a help message and exit with an exit status of 1 (otherwise exit with 0).

Once you have all the arguments, fork a child process and run the `/usr/bin/grep` command from the child process. If the
word can be found, the parent process will get an exit status of 0 and print that the word has been found. If not, the
parent process will print as such.


For example:

    $ parta
    USAGE:
      parta WORD

    $ parta fox
    fox found

    $ parta deer
    deer not found

### Part B

#### Background

In this part, you will use the `wc` command. This commands allows us to count the number of lines and the number of
words in a file. To count the number of lines, you write:

    $ wc -l tests/file1.txt

And you get the following output (1 line in the file `tests/file1.txt`).

    1 tests/file1.txt

And to count the number of words, you can do:

    $ wc -w tests/file1.txt
    9 tests/file1.txt

which means there are 9 words in the file.

#### The Task

Write a program that will takes two command line arguments. The first argument is the file to count. The second argument
controls which operation to do: count number of lines, or count number of words.

The second argument will be either `lines` or `words`. You need to compare the variable against either string, and you
can use the `strcmp` function to do so.

If you don't have enough arguments, or if the second argument doesn't match `lines` or `words`, then print a help
message and exit with an exit status of 1 (otherwise exit with 0).

Once you figure out which operation needs to be done, fork a new process. In the child process, run the `/usr/bin/wc`
command with the appropriate command-line arguments. The parent process just waits for the child to complete, and then
print "Child done". Note that the line above "Child done" is printed by the child process (i.e. `wc`)!

    $ partb tests/file1.txt lines
    1 tests/file1.txt
    Child done

    $ partb tests/file1.txt words
    9 tests/file1.txt
    Child done

