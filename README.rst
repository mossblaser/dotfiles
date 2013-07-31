ConMan: Configuration-file Manager
==================================

ConMan is tool for managing dotfiles and other config files on multiple unix
systems, each requiring largely the same set of files but with minor changes in
each location. The system is built on the m4 macro processor which is widely
installed and reasonably powerful.

Tutorial
--------

Configuration/dot file templates should be placed in ``ConMan/configs/*.m4``
(can be overridden by ``-t``). In the simplest case this requires just a single
modification. For example::
	
	CONFIG_FILE(my bash rc, ~/.bashrc)
	
	# bashrc continues as-per-normal below...

This defines the contents of ``~/.bashrc`` for all machines. Nice and straight
forward. Note: as this is still a 'normal' m4 script you must ensure that
templates don't accidentally trigger any m4 functionality.

Obviously this isn't very useful as we want to make things only appear for
certain machines. Say we have a config file we only want on machines in my
university department, we can make the config file conditional like so::
	
	CONFIG_FILE(ARCADE Settings, ~/.arcaderc, UNI)
	
	# ...configuration file for some university software here...

The extra argument here (``UNI``) is an expression saying which computers this
file should be present on. See the 'Defining Computers' section to see how you
define these names.

Given that your dotfiles are also now in m4 you can use other macros to clean up
your configs. Some macros are provided by ConMan to help make fine-grain
conditional inclusion easier::
	
	CONFIG_FILE(Example File, ~/.examplerc)
	
	These lines appear on all computers (as usual).
	
	ON_COMPUTER(LAPTOP)
		These lines only appear on my laptop's version of exaple RC.
		How lovely!
	ELSE_COMPUTER()
		These lines only appear on other computers' versions.
	END_COMPUTER()
	
	IF_COMPUTER(LAPTOP|UNI_RESEARCH_DOMAIN,
		`only appears on laptop & uni on the research domain',
		`appears everywhere else')

Finally, it is also worth noting that you can have multiple files defined in one
template. For example, your bashrc and bashprofile all in one template::
	
	CONFIG_FILE(my bashrc, ~/.bashrc)
	
	# Stuff from your bashrc goes here. Maybe you define/use some handy m4 macros?
	
	CONFIG_FILE(my bashprofile, ~/.bashprofile)
	
	# Stuff for the bash profile goes here (still the same file!). Maybe you can
	# use some of those handy macros again here too?

Defining Computers
``````````````````

A list of all the computers which your config files might apply to should be
defined in the 'global' configuration file ``ConMan/config.m4`` (or
alternatively the file specified by the ``-C`` argument) like so::
	
	DEFINE_COMPUTER(LAPTOP)
	DEFINE_COMPUTER(DESKTOP)
	DEFINE_COMPUTER(UNI_TEACHING_DOMAIN)
	DEFINE_COMPUTER(UNI_RESEARCH_DOMAIN)

It is also possible to group combinations of computers (and groups) under a
common label. For example, you can add::
	
	DEFINE_GROUP(PERSONAL, LAPTOP | DESKTOP)
	DEFINE_GROUP(UNI,      UNI_RESEARCH_DOMAIN | UNI_TEACHING_DOMAIN)

Each computer also has a 'local' configuration file ``ConMan/local_config.m4``
(or alternatively the file specified by the ``-c`` argument) which simply
defines which computer this actually is::
	
	SET_COMPUTER(LAPTOP)

Backups
```````

When a config file is created from a template, a backup is made in
``ConMan/backups`` (or the directory set by ``-b``). If the file being created
doesn't match its backup then you'll be asked to confirm the overwrite. This is
designed to protect against overwriting changes made to config files by other
utilities.

You can force ConMan to overwrite files which don't match their backups using
the ``-f`` option.


Quickly editing files
`````````````````````

Using ``conman -e filename`` will attempt to open the M4 file which created the
given file in your $EDITOR.


Health Warnings
---------------

There are a few thins you should be aware of when using ConMan. Hopefully these
should be resolved over time but for now...

1. It is worth mentioning a second time: your templates are just regular m4 and so
   must be careful to avoid any keywords etc. A list of extra keywords to avoid due
   to ConMan can be found by reading its source (sorry...).

2. Your m4 templates actually get parsed 1+n times (where n is the number of config
   files defined within it). This is due to the current bodge being used to get
   multiple files (and their file names) out of an m4 file. This may change to use
   a different bodge at some time in the future which solves this...

3. Be very careful using m4's ``divert`` command in your m4 scripts... Hopefully
   this will be cleaned up in the future...


Plugins
-------

ConMan can be extended with plugins giving it extra functionality. These are
documented below.

Git
```

The ``GIT_REPO(local_dir, repo_url)`` macro requests the git repo stored in
``local_dir`` is pulled from ``repo_url``. For example, here it is fetching
various VIM plugins::
	
	CONFIG_FILE(my vim configs, ~/.vimrc)
	
	" stuff for my .vimrc goes here as usual
	
	GIT_REPO(~/.vim/bundle/pathogen, git://github.com/tpope/vim-pathogen.git)
	GIT_REPO(~/.vim/bundle/fugitive, git://github.com/tpope/vim-fugitive.git)
	GIT_REPO(~/.vim/bundle/ctrlp,    git://github.com/kien/ctrlp.vim.git)

The plugin can be disabled using the ``-g`` flag.

Binary File Installer
`````````````````````

The ``INSTALL_BINARY(src, dst)`` macro copies a binary file (make sure it
doesn't end in .m4 to prevent conman processing it as a template) at the
location "src" (relative to the m4 file's directory) into dst. For example, this
installs a nice font for vim::
	
	CONFIG_FILE(my vim configs, ~/.vimrc)
	
	" stuff for my .vimrc goes here as usual
	
	INSTALL_BINARY(Monaco_Linux.ttf,~/.fonts/)

The plugin can be disabled using the ``-B`` flag.


For Plugin Developers
---------------------

ConMan searches for plugins in ``ConMan/plugins`` (but this can be overridden by
``-p``). There are two types of plugin:

* Files ending in ``.m4`` will be included after ConMan's header and before the
  target m4 file. What you do here is up to you. Have fun.

* Executable (bash) files ending in ``.sh`` will be sourced by ConMan. The
  rest of the documentation in this section describes the facilities available
  to the plugin writer.

Defining Macros
```````````````

The easiest way to define an macro is to define a suitable bash function and use
``add_m4_command`` to make it available to m4 like so::
	
	function touch_file() {
		touch "$1"
	}
	
	add_m4_command "TOUCH_FILE" "touch_file"

This defines the m4 macro ``TOUCH_FILE`` which essentially wraps the bash
function ``touch_file`` passing on all arguments. For example if you place the
following in a template::
	
	TOUCH_FILE(/tmp/some_file)dnl

The file ``/tmp/some_file`` will be touched.

Warning: Arguments given to the m4 wrapper will be (double) quoted but not
escaped so watch out!

The environment variable $M4_FILE is set with the full path of the m4 file which
called the the macro.


Defining Macros (Advanced)
``````````````````````````

You can append m4 commands into the file defined by ``$M4_INCLUDE`` which is
included by m4 after the ConMan header and before the target m4 file.


Adding ConMan Arguments
```````````````````````

You can add command-line arguments to ConMan.

Calling Functions
~~~~~~~~~~~~~~~~~

You can define an argument which, when given, executes a function using
``add_argument``. This takes an argument to match, a bash expression to eval
if found and a documentation string, e.g.::
	
	add_argument -t "echo testing $1;shift" "Print 'testing' and the argument on stdout."

Remember that arguments can be accessed via ``$1`` etc. remember to shift any
that you use.


Setting Variabls
~~~~~~~~~~~~~~~~

If you just want to add an argument that overrides a bash variable with the
argument given, you can use ``add_argument_var`` which takes an argument to
match, a variable name to override and a help string. For example::
	
	MY_VAR="initial value"
	add_argument_var -v "MY_VAR" "Override MY_VAR."

If called without an argument, ``$MY_VAR`` will remain '``initial value``' but
if called with ``-v something`` then ``$MY_VAR`` will be set to '``something``'.
