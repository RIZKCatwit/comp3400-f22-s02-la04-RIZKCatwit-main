#include <stdio.h>
#include <stdbool.h>
#include <string.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdlib.h>

/**
 * The main function. Note that you don't need Javadoc here,
 * although you still need document major blocks (ifs, fors, etc.)
 */
int main(int argc, char* argv[]) {
    // TODO: Complete this code and document
        if(argc != 2)
        {
          printf("USAGE:\n parta WORD\n\n");
          exit(1);
        }

        pid_t pid = fork();

        if(pid == 0)
        {
            char* args[]={"grep","-q",argv[1],"tests/file1.txt", NULL};
           
            int exec_ret = execv("/usr/bin/grep",args);
            if(exec_ret == -1)
            {
                perror("Problem with exec");
            }
        }
        int stat;
        waitpid(pid, &stat, 0);

        if(WIFEXITED(stat))
        {
            int exit_stat = WEXITSTATUS(stat);
            if(exit_stat==0)
            {
                printf("%s found", argv[1]);
            }
            else
            {
                printf("%s not found", argv[1]);
            }
        }

        
