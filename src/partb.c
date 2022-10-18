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
int main(int argc, char argv[]) {
    if(argc != 3) 
    {
        printf("USAGE:\n  partb FILENAME words|lines\n");
        exit(1);
    }

    else 
    {
        int c = fork();
        //building the child
        if(c == 0 && strcmp(argv[2], "words") == 0) 
        {
            char* a[] = 
            {
                "wc", "-w", argv[1], NULL
            };
            int ret = execv("/usr/bin/wc", a);
            if(ret == -1) 
            {
                printf("Problem with exec\n");
            }
        }       
    if (c == 0 && strcmp(argv[2], "lines") == 0) 
    {
      char * args[] = 
      {
        "wc",
        "-l",
        argv[1],
        NULL
      };
      int exec_ret = execv("/usr/bin/wc", args);
      if (exec_ret == -1) 
      { 
        perror("Problem with exec");
      }
    }

//parent-BUILDING
    else if (c > 0)
    {
        int status = 0;
        wait( & status);
        printf("Child done");
    }
}
    return 0;
}