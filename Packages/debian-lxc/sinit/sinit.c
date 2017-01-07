/* See LICENSE file for copyright and license details. */
#include <sys/types.h>
#include <sys/wait.h>

#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#define LEN(x) (sizeof (x) / sizeof *(x))

static void selfshutdown(void);
static void sigpoweroff(void);
static void sigreap(void);
static void sigreboot(void);
static void spawn(char *const []);

static struct {
	int sig;
	void (*handler)(void);
} sigmap[] = {
	{ SIGUSR1, sigpoweroff },
	{ SIGUSR2, selfshutdown },
	{ SIGCHLD, sigreap     },
	{ SIGINT,  sigreboot   },
};

#include "config.h"

static sigset_t set;

static int shutdown;
static int shutdown_pending;

int
main(void)
{
	shutdown=0;
	shutdown_pending=0;

	int sig;
	size_t i;

	if (getpid() != 1)
		return 1;
	chdir("/");
	sigfillset(&set);
	sigprocmask(SIG_BLOCK, &set, NULL);
	puts("init: starting up");
	fflush (stdout);
	spawn(rcinitcmd);
	while (shutdown==0) {
		sigwait(&set, &sig);
		printf("init: got signal #%d\n",sig);
		fflush (stdout);
		for (i = 0; i < LEN(sigmap); i++) {
			if (sigmap[i].sig == sig) {
				sigmap[i].handler();
				break;
			}
		}
	}
	puts("init: shutdown complete");
	return 0;
}

static void
sigpoweroff(void)
{
	puts("init: shutdown");
	fflush (stdout);
	spawn(rcpoweroffcmd);
}

static void
selfshutdown(void)
{
	puts("init: init shutdown pending");
	fflush (stdout);
	shutdown_pending=1;
}

static void
sigreap(void)
{
	while (waitpid(-1, NULL, WNOHANG) > 0)
		;
	if(shutdown_pending==1)
		shutdown=1;
}

static void
sigreboot(void)
{
	puts("init: reboot");
    fflush (stdout);
	spawn(rcrebootcmd);
}

static void
spawn(char *const argv[])
{
	pid_t pid;

	pid = fork();
	if (pid < 0) {
		perror("fork");
	} else if (pid == 0) {
		sigprocmask(SIG_UNBLOCK, &set, NULL);
		setsid();
		execvp(argv[0], argv);
		perror("execvp");
		_exit(1);
	}
}

