--------------------------------------------------------------------------------
M4 Macro Loop constructs for the more repetative commands:

# forloop(x, start, end, stmt)
define(`forloop',
       `pushdef(`$1', `$2')_forloop(`$1', `$2', `$3', `$4')popdef(`$1')')
define(`_forloop',
       `$4`'ifelse($1, `$3', ,
       `define(`$1', incr($1))_forloop(`$1', `$2', `$3', `$4')')')

# foreach(x, (item_1, item_2, ..., item_n), stmt)
#   parenthesized list, simple version
define(`foreach', `pushdef(`$1')_foreach($@)popdef(`$1')')
define(`_arg1', `$1')
define(`_foreach', `ifelse(`$2', `()', `',
  `define(`$1', _arg1$2)$3`'$0(`$1', (shift$2), `$3')')')

--------------------------------------------------------------------------------

M4 Macro which produces a profile for running jobs on a cluster of machines.
Usage: CLUSTER_PROFILE(profile_name, list_of_machines)
define(`CLUSTER_PROFILE', `
CONFIG_FILE(A remote profile called '$1`, ~/.parallel/'$1`)
SHARED_REMOTE_PROFILE()
--sshloginfile '$1.sshloginfile`
CONFIG_FILE(The sshloginfile for the profile '$1`, ~/.parallel/'$1`.sshloginfile)
'$2`
')

--------------------------------------------------------------------------------

M4 Macro which produces a list of computer names interleaving computers from different labs
Usage: LAB_MACHINES(space seperated lab prefixes, num_required)

define(`LAB_MACHINES', dnl
`esyscmd(for NUM in $(seq -f "%02.0f" '$2`); do for PREFIX in '$1`; do echo "$PREFIX$NUM" 2>/dev/null; done; done | head -n'$2`)'
)
 
--------------------------------------------------------------------------------
M4 Macro which defines the standard configuration options for all profiles.

define(`STD_PROFILE', `
--env _
--wd .
')

--------------------------------------------------------------------------------

M4 Macro which defines the standard configuration options for running on remote machines
define(`REMOTE_PROFILE', `
STD_PROFILE()
--controlmaster
--filter-hosts
--retries 2
')

--------------------------------------------------------------------------------

M4 Macro which defines the standard configuration options for running on remote
machines which may be being used by other people.
define(`SHARED_REMOTE_PROFILE', `
REMOTE_PROFILE()
--nice 17
--load 4%
')

--------------------------------------------------------------------------------

A list of common Kilburn lab machine prefixes
define(`KILBURN_LAB_PREFIXES',e-c07kilf9 e-c07kilf16 e-c07kilf31 e-c07kig23)

--------------------------------------------------------------------------------

CONFIG_FILE(A job profile for most local work, ~/.parallel/local)
STD_PROFILE()

CONFIG_FILE(A job profile for most cluster work, ~/.parallel/remote)
REMOTE_PROFILE()

CONFIG_FILE(A job profile for most cluster work on public computers, ~/.parallel/shared_remote)
REMOTE_PROFILE()

dnl ----------------------------------------------------------------------------
dnl University of Manchester Lab Machine Clusters
dnl ----------------------------------------------------------------------------

ON_COMPUTER(UNI_TEACHING)

dnl Just use the "Kilburn" machine
CLUSTER_PROFILE(kilburn,`kilburn')

dnl Defines cluster[n] for various n which are powers of two using the kilburn
dnl lab machines.
foreach(`NUM_MACHINES',(4,8,16,32,64,128,256),`dnl
CLUSTER_PROFILE(`cluster`'NUM_MACHINES',`dnl
LAB_MACHINES(KILBURN_LAB_PREFIXES, NUM_MACHINES)dnl
')dnl
')

END_COMPUTER()


