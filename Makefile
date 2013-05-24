##
## Generic Makefile implementation for C/C++ projects.
## By Jeremie Taboada <taboada.jeremie@gmail.com>
##

##
## Configuration.
##

# Program's name.

NAME		= hi

# Extensions and compilator.

CC		= clang
EXTENSION 	= c

# Directories.

INCS_DIR	= includes
SRCS_DIR	= sources
OBJS_DIR	= objects
LIB_DIR		= librairies
INSTALL_DIR	= /usr/bin

# Flags.

CFLAGS		+= -I $(INCS_DIR)

##
## Common variables.
##

ifneq ($(NOWARN), true)
CFLAGS		+= -Wall -Wextra -Werror
endif

ifeq ($(DEBUG), true)
CFLAGS		+= -ggdb3
endif

ifeq ($(OPTI), true)
CFLAGS		+= -03
endif

SRCS		= $(shell find $(SRCS_DIR) -type f -name *.$(EXTENSION))
OBJS		= $(patsubst $(SRCS_DIR)/%,$(OBJS_DIR)/%,$(SRCS:.$(EXTENSION)=.o))
DEPS		= $(OBJS:.o=.d)

NAME		?= program
CC		?= cc
EXTENSION	?= c

MAKE		= make --no-print-directory -C
RM		= rm -f
MV		= mv -f
CP		= cp -f
ECHO		= echo
AR		= ar
RANLIB		= ranlib

##
## Rules.
##

all		: $(NAME)

# Unit tests.

test		:
		  @$(ECHO) "Unit tests are not implemented."

# Documentation.

doc		:
		  @$(ECHO) "Documentation is not implemented."

# Compilation.

$(NAME)		: $(OBJS)
		  @$(ECHO) "Linkage of $@..."
		  @$(CC) $^ -o $@ $(LFLAGS)

$(OBJS_DIR)/%.o	: $(SRCS_DIR)/%.$(EXTENSION)
		  @$(ECHO) "Compilation of $*..."
		  @mkdir -p $(OBJS_DIR)
		  @$(CC) $(CFLAGS) -MD -MF $(@:.o=.d) -c -o $@ $<

# Commons.

run		: all
		  ./$(NAME)

clean		:
		  @$(ECHO) "Remove objects and dependencies..."
		  @$(RM) $(OBJS) $(DEPS)

fclean		: clean
		  @$(ECHO) "Remove executable..."
		  @$(RM) $(NAME)

re		: fclean all

-include $(DEPS)

.PHONY		: all test doc clean fclean re