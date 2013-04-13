divert(-1)

dnl The M4 header used by ConMan.
dnl
dnl The following should always be defined:
dnl   M4_FILE: The filename of the M4 file which is being processed
dnl
dnl If making the first pass:
dnl   SCRIPT_FILE: The file to append script commands to
dnl   OUTPUT_ID: [undefined]
dnl
dnl If making the second pass:
dnl   SCRIPT_FILE: /dev/null
dnl   OUTPUT_ID: The ID of the config file to be output


dnl ============================================================================
dnl ID Number Generation
dnl ============================================================================

dnl Use NEXT_ID and INC_NEXT_ID for generating unique ids.
define(`NEXT_ID', 0)
define(INC_NEXT_ID, `define(`NEXT_ID', incr(NEXT_ID))')


dnl ============================================================================
dnl Comupter definition macros
dnl ============================================================================

dnl The local config should use SET_COMPUTER to specify which computer is used.
dnl This macro defines the value of COMPUTER which is used when testing.
define(SET_COMPUTER, `define(COMPUTER, $1)')

dnl The global config defines computers and groups which may exist.
dnl These macros evaluate to either 1 or 0 depending on whether the local
dnl computer matches the specification.
define(DEFINE_COMPUTER, `define($1, ifelse(COMPUTER, $1, 1, 0))')
define(DEFINE_GROUP, `define($1, eval($2))')

dnl ============================================================================
dnl Computer-Dependent Conditionals
dnl ============================================================================

dnl If $1 evaluates to 1, $2, else $3
define(IF_COMPUTER, `ifelse(eval($1), 1, `$2', `$3')')

dnl Hacky conditional sections.
dnl For example:
dnl   ON_COMPUTER(FOO)
dnl   <stuff for computer foo>
dnl   ELSE_COMPUTER()
dnl   <stoff for !foo>
dnl   END_COMPUTER()
define(ON_COMPUTER, `pushdef(`OLD_OUTPUT', divnum)IF_COMPUTER($1, , `divert(-1)')dnl')
define(END_COMPUTER, `divert(OLD_OUTPUT)popdef(`OLD_OUTPUT')dnl')
define(ELSE_COMPUTER, `divert(ifelse(divnum, -1, OLD_OUTPUT, -1))dnl')


dnl ============================================================================
dnl Script file macros
dnl ============================================================================

dnl Add a command to append commands to the script file which is generated in
dnl the first pass.
define(ADD_TO_SCRIPT, `syscmd(echo "$1" >> "SCRIPT_FILE")')

dnl Convert a set of M4 arguments into a space-seperated list of quoted (but not
dnl propperly escaped) strings for the purpose of expanding to an argument list.
dnl Example: SCRIPT_ARGS(1,2,3,4) -> "1" "2" "3" "4"
define(SCRIPT_ARGS, `ifelse($1,,,`"$1"`'ifelse($2,,,` ')`'SCRIPT_ARGS(shift($@))')')


dnl ============================================================================
dnl Config File Support
dnl ============================================================================

dnl Produce a config file.
dnl
dnl In the first pass this adds a line to the script which requests each
dnl CONFIG_FILE section be placed in the appropriate file in the second pass.
dnl
dnl Arguments:
dnl   - Config name -- not currently used for anything,
dnl   - File name -- Where to put this section.
dnl   - Enabled (optional) -- Boolean expression; should this be generated?
define(CONFIG_FILE,
`IF_COMPUTER(eval(ifelse($3,,1,$3)),
	`ADD_TO_SCRIPT(config_file NEXT_ID $1 $2 M4_FILE)')dnl
ifelse(NEXT_ID, OUTPUT_ID, `divert(0)', `divert(-1)')dnl
INC_NEXT_ID()dnl')
