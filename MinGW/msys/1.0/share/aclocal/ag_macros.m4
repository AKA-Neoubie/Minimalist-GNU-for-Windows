dnl  -*- buffer-read-only: t -*- vi: set ro:
dnl 
dnl DO NOT EDIT THIS FILE   (ag_macros.m4)
dnl 
dnl It has been AutoGen-ed  March  3, 2010 at 11:25:08 AM by AutoGen 5.10.1
dnl From the definitions    misc.def
dnl and the template file   conftest.tpl
dnl
dnl do always after generated macros:
dnl
AC_DEFUN([INVOKE_AG_MACROS_LAST],[
[if test X${INVOKE_AG_MACROS_LAST_done} != Xyes ; then]
  AC_CHECK_HEADERS(libio.h ctype.h assert.h)
  INVOKE_LIBOPTS_MACROS
  AC_CHECK_DECLS([sigsetjmp],,, [#include <setjmp.h>])
  AC_CHECK_FUNCS(fopencookie funopen, break)
  case "${ac_cv_func_fopencookie}${ac_cv_func_funopen}" in
  *yes* )
     AC_DEFINE([ENABLE_FMEMOPEN], 1, "Define if we can use it")
     ;;
  esac
  AC_C_INLINE
  
  # Note that BSD does not typedef these in its headers, but instead
  # calls for them to be identical in signature to read(2), write(2),
  # lseek(2), and close(2).  Newlib however does include typedefs
  # in its stdio.h for these, and they do not match the signatures
  # of the BSD implementation.  So this test relies on the fact
  # that any typedef will succeed for BSD, while only one that
  # matches the existing definitions in stdio.h will succeed for
  # a newlib system.
  
  if test "X${ac_cv_func_funopen}" = Xyes; then
    AC_CACHE_CHECK([for cookie_function_t type],
      [ag_cv_cookie_function_t],
      [AC_TRY_COMPILE([#include <stdio.h>
        typedef int cookie_read_function_t (void *, char *, int);
        ], [], ag_cv_cookie_function_t="bsd",
        AC_TRY_COMPILE([#include <stdio.h>
          typedef ssize_t cookie_read_function_t (void *, char *, size_t);
          ], [], ag_cv_cookie_function_t="newlib",
          AC_MSG_ERROR([Unknown flavor of cookie_XXX_t types])))])
  fi	  
  if test "X${ag_cv_cookie_function_t}" = Xbsd; then
    AC_DEFINE([NEED_COOKIE_FUNCTION_TYPEDEFS], [1],
      [Define if typedefs for the funopen function pointers are required.])
  fi
  
  AC_CACHE_CHECK([for static inline], [snv_cv_static_inline], [
  AC_TRY_COMPILE([static inline foo(bar) int bar; { return bar; }],
    [return foo(0);],
    [snv_cv_static_inline='static inline'],
    [snv_cv_static_inline='static'])
  ])
  AC_DEFINE_UNQUOTED(SNV_INLINE, ${snv_cv_static_inline},
           [define to static or static inline])
  [if test "X${libopts_cv_with_libregex}" = Xno
  then
    echo "I cannot detect POSIX compliant regcomp/regexec routines.
  These are required for AutoGen to work correctly.  If you have
  such a library present on your system, you must specify it by
  setting the LIBS environment variable, e.g., \"LIBS='-lregex'\".
  If you do not have such a library on your system, then you should
  download and install, for example, the one from:
      ftp://ftp.gnu.org/gnu/rx/" >&2]
    AC_MSG_ERROR([Cannot find working POSIX regex library])
  [fi]
  AC_PROG_GREP
  AC_PROG_EGREP
  AC_PROG_FGREP
[  INVOKE_AG_MACROS_LAST_done=yes
fi]])

dnl
dnl @synopsis  INVOKE_AG_MACROS
dnl
dnl  This macro will invoke the AutoConf macros specified in misc.def
dnl  that have not been disabled with "omit-invocation".
dnl
AC_DEFUN([AG_DISABLE_SHELL],[
  AC_ARG_ENABLE([shell],
    AC_HELP_STRING([--disable-shell], [shell scripts are desired]),
    [ag_cv_enable_shell=${enable_shell}],
    AC_CACHE_CHECK([whether shell scripts are desired], ag_cv_enable_shell,
      ag_cv_enable_shell=yes)
  ) # end of AC_ARG_ENABLE

  if test "X${ag_cv_enable_shell}" != Xno
  then
    AC_FUNC_FORK
  fi
  
]) # end of AC_DEFUN of AG_DISABLE_SHELL


AC_DEFUN([AG_TEST_DO_SHELL],[
  AC_MSG_CHECKING([whether using shell scripts])
  AC_CACHE_VAL([ag_cv_test_do_shell],[
    ag_cv_test_do_shell=`exec 2> /dev/null
test "x$ac_cv_func_fork_works" = xyes && test "x$ag_cv_enable_shell" = xyes || exit 1 ; echo yes`
    if test $? -ne 0
    then ag_cv_test_do_shell=no
    elif test -z "$ag_cv_test_do_shell"
    then ag_cv_test_do_shell=no
    fi
  ]) # end of CACHE_VAL of ag_cv_test_do_shell
  AC_MSG_RESULT([${ag_cv_test_do_shell}])

  if test "X${ag_cv_test_do_shell}" != Xno
  then
    AC_SUBST(OPTS_TESTDIR)
AC_SUBST(AGEN5_TESTS)
AC_DEFINE([SHELL_ENABLED], [1], [Define if shell scripts are enabled])
OPTS_TESTDIR=test
AGEN5_TESTS='$(SHELL_TESTS) $(NOSHELL_TESTS)'
  else
    OPTS_TESTDIR=
AGEN5_TESTS='$(NOSHELL_TESTS)'
  fi
  AM_CONDITIONAL([DO_SHELL_CMDS],[test "X${ag_cv_test_do_shell}" != Xno])
  
]) # end of AC_DEFUN of AG_TEST_DO_SHELL


AC_DEFUN([AG_LINK_SETJMP],[
  AC_MSG_CHECKING([whether setjmp() links okay])
  AC_CACHE_VAL([ag_cv_link_setjmp],[
  AC_TRY_LINK([@%:@include <setjmp.h>],
    [jmp_buf bf;
if (setjmp(bf))
  return 0;
return 0;],
    [ag_cv_link_setjmp=yes],[ag_cv_link_setjmp=no]
  ) # end of TRY_LINK
  ]) # end of AC_CACHE_VAL for ag_cv_link_setjmp
  AC_MSG_RESULT([${ag_cv_link_setjmp}])

  if test "X${ag_cv_link_setjmp}" != Xno
  then
    AC_DEFINE(HAVE_WORKING_SETJMP, 1, @<:@setjmp links okay@:>@)
  fi
  
]) # end of AC_DEFUN of AG_LINK_SETJMP


AC_DEFUN([AG_LINK_SIGSETJMP],[
  AC_MSG_CHECKING([whether sigsetjmp() links okay])
  AC_CACHE_VAL([ag_cv_link_sigsetjmp],[
  AC_TRY_LINK([@%:@include <setjmp.h>],
    [sigjmp_buf bf;
if (sigsetjmp(bf,0))
  return 0;
return 0;],
    [ag_cv_link_sigsetjmp=yes],[ag_cv_link_sigsetjmp=no]
  ) # end of TRY_LINK
  ]) # end of AC_CACHE_VAL for ag_cv_link_sigsetjmp
  AC_MSG_RESULT([${ag_cv_link_sigsetjmp}])

  if test "X${ag_cv_link_sigsetjmp}" != Xno
  then
    AC_DEFINE(HAVE_WORKING_SIGSETJMP, 1, @<:@sigsetjmp links okay@:>@)
  fi
  
]) # end of AC_DEFUN of AG_LINK_SIGSETJMP


AC_DEFUN([AG_WITHLIB_GUILE],[
  AC_ARG_WITH([libguile],
    AC_HELP_STRING([--with-libguile], [libguile installation prefix]),
    [ag_cv_with_libguile_root=${with_libguile}],
    AC_CACHE_CHECK([whether with-libguile was specified], ag_cv_with_libguile_root,
      ag_cv_with_libguile_root=no)
  ) # end of AC_ARG_WITH libguile

  if test "${with_libguile+set}" = set && \
     test "${withval}" = no
  then ## disabled by request
    ag_cv_with_libguile_root=no
    ag_cv_with_libguile_cflags=no
    ag_cv_with_libguile_libs=no
  else

  AC_ARG_WITH([libguile-cflags],
    AC_HELP_STRING([--with-libguile-cflags], [libguile compile flags]),
    [ag_cv_with_libguile_cflags=${with_guile_cflags}],
    AC_CACHE_CHECK([whether with-libguile-cflags was specified], ag_cv_with_libguile_cflags,
      ag_cv_with_libguile_cflags=no)
  ) # end of AC_ARG_WITH libguile-cflags

  AC_ARG_WITH([libguile-libs],
    AC_HELP_STRING([--with-libguile-libs], [libguile link command arguments]),
    [ag_cv_with_libguile_libs=${with_guile_libs}],
    AC_CACHE_CHECK([whether with-libguile-libs was specified], ag_cv_with_libguile_libs,
      ag_cv_with_libguile_libs=no)
  ) # end of AC_ARG_WITH libguile-libs

  case "X${ag_cv_with_libguile_cflags}" in
  Xyes|Xno|X )
    case "X${ag_cv_with_libguile_root}" in
    Xyes|Xno|X ) ag_cv_with_libguile_cflags=no ;;
    * )        ag_cv_with_libguile_cflags=-I${ag_cv_with_libguile_root}/include ;;
    esac
  esac
  case "X${ag_cv_with_libguile_libs}" in
  Xyes|Xno|X )
    case "X${ag_cv_with_libguile_root}" in
    Xyes|Xno|X ) ag_cv_with_libguile_libs=no ;;
    * )        ag_cv_with_libguile_libs="-L${ag_cv_with_libguile_root}/lib -lguile";;
    esac
  esac
  ag_save_CPPFLAGS="${CPPFLAGS}"
  ag_save_LIBS="${LIBS}"
  case "X${ag_cv_with_libguile_cflags}" in
  Xyes|Xno|X )
    f=`guile-config compile 2>/dev/null` || f=''
    test -n "${f}" && ag_cv_with_libguile_cflags="${f}" && \
      AC_MSG_NOTICE([guile-config used for CFLAGS: $f]) ;;
  esac
  case "X${ag_cv_with_libguile_libs}" in
  Xyes|Xno|X )
    f=`guile-config link 2>/dev/null` || f=''
    test -n "${f}" && ag_cv_with_libguile_libs="${f}" && \
      AC_MSG_NOTICE([guile-config used for LIBS: $f]) ;;
  esac
  fi ## disabled by request

  case "X${ag_cv_with_libguile_cflags}" in
  Xyes|Xno|X )
    ag_cv_with_libguile_cflags="" ;;
  * ) CPPFLAGS="${CPPFLAGS} ${ag_cv_with_libguile_cflags}" ;;
  esac
  case "X${ag_cv_with_libguile_libs}" in
  Xyes|Xno|X )
    LIBS="${LIBS} -lguile"
    ag_cv_with_libguile_libs="-lguile" ;;
  * )
    LIBS="${LIBS} ${ag_cv_with_libguile_libs}" ;;
  esac
  LIBGUILE_CFLAGS=""
  LIBGUILE_LIBS=""
  AC_MSG_CHECKING([whether libguile can be linked with])
  AC_CACHE_VAL([ag_cv_with_libguile],[
  AC_LINK_IFELSE([[@%:@include <guile/gh.h>
@%:@include <libguile/list.h>
@%:@if ((SCM_MAJOR_VERSION * 100) + SCM_MINOR_VERSION) > 108
This has not been tested with Guile 1.9.  Remove this line to proceed.
@%:@endif
int main () {
  SCM fumble = SCM_UNDEFINED;
  SCM bumble = SCM_UNDEFINED;
  SCM stumble= SCM_UNDEFINED;
  long lstumble;
  stumble = scm_cons( fumble, bumble );
  stumble = scm_display( fumble, bumble );
  lstumble = scm_ilength( fumble );
  stumble = scm_makstr( 1, 2 );
  stumble = gh_eval_str( "stumble" );
  scm_misc_error( "oops", "bad", bumble );
  stumble = scm_num_eq_p( fumble, bumble );
  scm_wrong_type_arg( "oops", 1, bumble );
  return 0; }]],
    [ag_cv_with_libguile=yes],
    [ag_cv_with_libguile=no]) # end of AC_LINK_IFELSE 
  ]) # end of AC_CACHE_VAL for ag_cv_with_libguile
  AC_MSG_RESULT([${ag_cv_with_libguile}])
    AC_SUBST([LIBGUILE_CFLAGS])
    AC_SUBST([LIBGUILE_LIBS])
    AC_SUBST([LIBGUILE_PATH])

  if test "X${ag_cv_with_libguile}" != Xno
  then[
      LIBGUILE_CFLAGS="${ag_cv_with_libguile_cflags}"
      LIBGUILE_LIBS="${ag_cv_with_libguile_libs}"
      case "${LIBGUILE_LIBS}" in *-L* )
        LIBGUILE_PATH=`echo ,${LIBGUILE_LIBS} |           sed 's/.*[, ]-L[ 	]*//;s/[ 	].*//'`
      ;; * ) LIBGUILE_PATH='' ;; esac]
      CPPFLAGS="@S|@{ag_save_CPPFLAGS}"
  LIBS="@S|@{ag_save_LIBS}"
  else
    CPPFLAGS="${ag_save_CPPFLAGS}"
    LIBS="${ag_save_LIBS}"
      LIBGUILE_CFLAGS=''
      LIBGUILE_LIBS=''
      LIBGUILE_PATH=''
      AC_MSG_ERROR([Cannot find libguile.  libguile is required.])
  fi
  AC_SUBST([AG_GUILE])
  
]) # end of AC_DEFUN of AG_WITHLIB_GUILE


AC_DEFUN([AG_TEST_GUILE_VERSION],[
  AC_MSG_CHECKING([whether the guile version])
  AC_CACHE_VAL([ag_cv_test_guile_version],[
    ag_cv_test_guile_version=`exec 2> /dev/null
pkginfo=\`dpkg --list 2>/dev/null | egrep 'guile-[0-9.]-dev'\`
if test -n "${pkginfo}"
then echo ${pkginfo} | sed -e 's/.*guile-//' -e 's/-dev.*//'
else
  v=\`( guile-config --version 2>&1 ) | sed 's/.*Guile version *//'\`
  test -z "${v}" && v=\`guile --version | sed 's/.*Guile *//;1q'\`
  test -z "${v}" && exit 1
  echo ${v}
fi`
    if test $? -ne 0
    then ag_cv_test_guile_version=no
    elif test -z "$ag_cv_test_guile_version"
    then ag_cv_test_guile_version=no
    fi
  ]) # end of CACHE_VAL of ag_cv_test_guile_version
  AC_MSG_RESULT([${ag_cv_test_guile_version}])

  if test "X${ag_cv_test_guile_version}" != Xno
  then
    set -- `IFS=' .' ; echo ${ag_cv_test_guile_version}`
i=${3}
test -z "${i}" && i=0
GUILE_VERSION=`expr ${1} \* 100000 + ${2} \* 1000 + ${i}`
AC_DEFINE_UNQUOTED([GUILE_VERSION], [${GUILE_VERSION}],
         [define to Guile version expression])
AC_SUBST(GUILE_VERSION)
  else
    AC_MSG_ERROR(@<:@Cannot determine Guile version number@:>@)
  fi
  
]) # end of AC_DEFUN of AG_TEST_GUILE_VERSION


AC_DEFUN([AG_LINK_EVAL_STRING],[
  AC_MSG_CHECKING([whether scm_primitive_eval_x links])
  AC_CACHE_VAL([ag_cv_link_eval_string],[
    ag_save_CPPFLAGS="${CPPFLAGS}"
    CPPFLAGS="${ag_cv_with_libguile_cflags} ${CPPFLAGS}"
    ag_save_LIBS="${LIBS}"
    LIBS="${ag_cv_with_libguile_libs} ${LIBS}"
  AC_TRY_LINK([@%:@include <guile/gh.h>
@%:@include <libguile.h>],
    [SCM res = scm_primitive_eval_x( SCM_UNDEFINED );],
    [ag_cv_link_eval_string=yes],[ag_cv_link_eval_string=no]
  ) # end of TRY_LINK
    CPPFLAGS="${ag_save_CPPFLAGS}"
    LIBS="${ag_save_LIBS}"
  ]) # end of AC_CACHE_VAL for ag_cv_link_eval_string
  AC_MSG_RESULT([${ag_cv_link_eval_string}])

  if test "X${ag_cv_link_eval_string}" = Xno
  then
    AC_DEFINE([scm_primitive_eval_x], [scm_eval_x],
        [Define this if no scm_primitive_eval_x])
AC_DEFINE([scm_t_port], [scm_port], [Define this if no scm_t_port])
  fi
  
]) # end of AC_DEFUN of AG_LINK_EVAL_STRING


AC_DEFUN([AG_WITHLIB_XML2],[
  AC_ARG_WITH([libxml2],
    AC_HELP_STRING([--with-libxml2], [libxml2 installation prefix]),
    [ag_cv_with_libxml2_root=${with_libxml2}],
    AC_CACHE_CHECK([whether with-libxml2 was specified], ag_cv_with_libxml2_root,
      ag_cv_with_libxml2_root=no)
  ) # end of AC_ARG_WITH libxml2

  if test "${with_libguile+set}" = set && \
     test "${withval}" = no
  then ## disabled by request
    ag_cv_with_libxml2_root=no
    ag_cv_with_libxml2_cflags=no
    ag_cv_with_libxml2_libs=no
  else

  AC_ARG_WITH([libxml2-cflags],
    AC_HELP_STRING([--with-libxml2-cflags], [libxml2 compile flags]),
    [ag_cv_with_libxml2_cflags=${with_xml2_cflags}],
    AC_CACHE_CHECK([whether with-libxml2-cflags was specified], ag_cv_with_libxml2_cflags,
      ag_cv_with_libxml2_cflags=no)
  ) # end of AC_ARG_WITH libxml2-cflags

  AC_ARG_WITH([libxml2-libs],
    AC_HELP_STRING([--with-libxml2-libs], [libxml2 link command arguments]),
    [ag_cv_with_libxml2_libs=${with_xml2_libs}],
    AC_CACHE_CHECK([whether with-libxml2-libs was specified], ag_cv_with_libxml2_libs,
      ag_cv_with_libxml2_libs=no)
  ) # end of AC_ARG_WITH libxml2-libs

  case "X${ag_cv_with_libxml2_cflags}" in
  Xyes|Xno|X )
    case "X${ag_cv_with_libxml2_root}" in
    Xyes|Xno|X ) ag_cv_with_libxml2_cflags=no ;;
    * )        ag_cv_with_libxml2_cflags=-I${ag_cv_with_libxml2_root}/include ;;
    esac
  esac
  case "X${ag_cv_with_libxml2_libs}" in
  Xyes|Xno|X )
    case "X${ag_cv_with_libxml2_root}" in
    Xyes|Xno|X ) ag_cv_with_libxml2_libs=no ;;
    * )        ag_cv_with_libxml2_libs="-L${ag_cv_with_libxml2_root}/lib -lxml2";;
    esac
  esac
  ag_save_CPPFLAGS="${CPPFLAGS}"
  ag_save_LIBS="${LIBS}"
  case "X${ag_cv_with_libxml2_cflags}" in
  Xyes|Xno|X )
    f=`xml2-config --cflags 2>/dev/null` || f=''
    test -n "${f}" && ag_cv_with_libxml2_cflags="${f}" && \
      AC_MSG_NOTICE([xml2-config used for CFLAGS: $f]) ;;
  esac
  case "X${ag_cv_with_libxml2_libs}" in
  Xyes|Xno|X )
    f=`xml2-config --libs 2>/dev/null` || f=''
    test -n "${f}" && ag_cv_with_libxml2_libs="${f}" && \
      AC_MSG_NOTICE([xml2-config used for LIBS: $f]) ;;
  esac
  fi ## disabled by request

  case "X${ag_cv_with_libxml2_cflags}" in
  Xyes|Xno|X )
    ag_cv_with_libxml2_cflags="" ;;
  * ) CPPFLAGS="${CPPFLAGS} ${ag_cv_with_libxml2_cflags}" ;;
  esac
  case "X${ag_cv_with_libxml2_libs}" in
  Xyes|Xno|X )
    LIBS="${LIBS} -lxml2"
    ag_cv_with_libxml2_libs="-lxml2" ;;
  * )
    LIBS="${LIBS} ${ag_cv_with_libxml2_libs}" ;;
  esac
  LIBXML2_CFLAGS=""
  LIBXML2_LIBS=""
  AC_MSG_CHECKING([whether libxml2 can be linked with])
  AC_CACHE_VAL([ag_cv_with_libxml2],[
  AC_LINK_IFELSE([[@%:@include <libxml/parser.h>
@%:@include <libxml/tree.h>

int main () {
xmlDocPtr p = xmlParseFile( "mumble.xml" ); }]],
    [ag_cv_with_libxml2=yes],
    [ag_cv_with_libxml2=no]) # end of AC_LINK_IFELSE 
  ]) # end of AC_CACHE_VAL for ag_cv_with_libxml2
  AC_MSG_RESULT([${ag_cv_with_libxml2}])
    AC_SUBST([LIBXML2_CFLAGS])
    AC_SUBST([LIBXML2_LIBS])
    AC_SUBST([LIBXML2_PATH])

  if test "X${ag_cv_with_libxml2}" != Xno
  then[
      LIBXML2_CFLAGS="${ag_cv_with_libxml2_cflags}"
      LIBXML2_LIBS="${ag_cv_with_libxml2_libs}"
      case "${LIBXML2_LIBS}" in *-L* )
        LIBXML2_PATH=`echo ,${LIBXML2_LIBS} |           sed 's/.*[, ]-L[ 	]*//;s/[ 	].*//'`
      ;; * ) LIBXML2_PATH='' ;; esac]
    CPPFLAGS="@S|@{ag_save_CPPFLAGS}"
    LIBS="@S|@{ag_save_LIBS}"
    
  else
    CPPFLAGS="${ag_save_CPPFLAGS}"
    LIBS="${ag_save_LIBS}"
      LIBXML2_CFLAGS=''
      LIBXML2_LIBS=''
      LIBXML2_PATH=''
  fi
  AC_SUBST([AG_XML2])
  AM_CONDITIONAL([HAVE_XML_LIB],[test "X${ag_cv_with_libxml2}" != Xno])
  
]) # end of AC_DEFUN of AG_WITHLIB_XML2


AC_DEFUN([AG_RUN_FATTACH],[
  AC_MSG_CHECKING([whether fattach runs])
  AC_CACHE_VAL([ag_cv_run_fattach],[
  AC_TRY_RUN([int main(int argc,char** argv) {
        int fds@<:@2@:>@;
        pipe(fds);
        return fattach(fds@<:@0@:>@,__FILE__);
return 0; }],
    [ag_cv_run_fattach=yes],[ag_cv_run_fattach=no],[ag_cv_run_fattach=no]
  ) # end of TRY_RUN
  ]) # end of AC_CACHE_VAL for ag_cv_run_fattach
  AC_MSG_RESULT([${ag_cv_run_fattach}])

  if test "X${ag_cv_run_fattach}" != Xno
  then
    AC_DEFINE([HAVE_FATTACH],[1],
        [Define this if fattach runs])
  fi
  
]) # end of AC_DEFUN of AG_RUN_FATTACH


AC_DEFUN([AG_RUN_CONNLD],[
  AC_MSG_CHECKING([whether connld works])
  AC_CACHE_VAL([ag_cv_run_connld],[
  AC_TRY_RUN([int main(int argc,char** argv) {
        int fds@<:@2@:>@;
        pipe(fds);
        return ioctl( fds@<:@0@:>@, I_PUSH, "connld" );
return 0; }],
    [ag_cv_run_connld=yes],[ag_cv_run_connld=no],[ag_cv_run_connld=no]
  ) # end of TRY_RUN
  ]) # end of AC_CACHE_VAL for ag_cv_run_connld
  AC_MSG_RESULT([${ag_cv_run_connld}])

  if test "X${ag_cv_run_connld}" != Xno
  then
    AC_DEFINE([HAVE_CONNLD],[1],
        [Define this if connld works])
  fi
  
]) # end of AC_DEFUN of AG_RUN_CONNLD


AC_DEFUN([AG_RUN_SOLARIS_SYSINFO],[
  AC_MSG_CHECKING([whether sysinfo(2) is Solaris])
  AC_CACHE_VAL([ag_cv_run_solaris_sysinfo],[
  AC_TRY_RUN([@%:@include <sys/systeminfo.h>
int main() { char z@<:@ 256 @:>@;
long sz = sysinfo( SI_SYSNAME, z, sizeof( z ));
return (sz > 0) ? 0 : 1; }],
    [ag_cv_run_solaris_sysinfo=yes],[ag_cv_run_solaris_sysinfo=no],[ag_cv_run_solaris_sysinfo=no]
  ) # end of TRY_RUN
  ]) # end of AC_CACHE_VAL for ag_cv_run_solaris_sysinfo
  AC_MSG_RESULT([${ag_cv_run_solaris_sysinfo}])

  if test "X${ag_cv_run_solaris_sysinfo}" != Xno
  then
    AC_DEFINE([HAVE_SOLARIS_SYSINFO],[1],
        [Define this if sysinfo(2) is Solaris])
  fi
  
]) # end of AC_DEFUN of AG_RUN_SOLARIS_SYSINFO


AC_DEFUN([AG_RUN_STRCSPN],[
  AC_MSG_CHECKING([whether strcspn matches prototype and works])
  AC_CACHE_VAL([ag_cv_run_strcspn],[
  AC_TRY_RUN([@%:@include <string.h>
int main (int argc, char** argv) {
   char zRej@<:@@:>@ = "reject";
   char zAcc@<:@@:>@ = "a-ok-eject";
   return strcspn( zAcc, zRej ) - 5;
}],
    [ag_cv_run_strcspn=yes],[ag_cv_run_strcspn=no],[ag_cv_run_strcspn=no]
  ) # end of TRY_RUN
  ]) # end of AC_CACHE_VAL for ag_cv_run_strcspn
  AC_MSG_RESULT([${ag_cv_run_strcspn}])

  if test "X${ag_cv_run_strcspn}" != Xno
  then
    AC_DEFINE([HAVE_STRCSPN],[1],
        [Define this if strcspn matches prototype and works])
  else
    COMPATOBJ="@S|@COMPATOBJ strcspn.lo"
  fi
  
]) # end of AC_DEFUN of AG_RUN_STRCSPN


AC_DEFUN([AG_RUN_SYS_SIGLIST],[
  AC_MSG_CHECKING([whether there is a global text array sys_siglist])
  AC_CACHE_VAL([ag_cv_run_sys_siglist],[
  AC_TRY_RUN([@%:@include <signal.h>
int main() {
  char const* pz = sys_siglist@<:@1@:>@;
  return (pz != 0) ? 0 : 1; }],
    [ag_cv_run_sys_siglist=yes],[ag_cv_run_sys_siglist=no],[ag_cv_run_sys_siglist=no]
  ) # end of TRY_RUN
  ]) # end of AC_CACHE_VAL for ag_cv_run_sys_siglist
  AC_MSG_RESULT([${ag_cv_run_sys_siglist}])

  if test "X${ag_cv_run_sys_siglist}" != Xno
  then
    AC_DEFINE([HAVE_SYS_SIGLIST],[1],
        [Define this if there is a global text array sys_siglist])
  fi
  
]) # end of AC_DEFUN of AG_RUN_SYS_SIGLIST


AC_DEFUN([AG_RUN_UNAME_SYSCALL],[
  AC_MSG_CHECKING([whether uname(2) is POSIX])
  AC_CACHE_VAL([ag_cv_run_uname_syscall],[
  AC_TRY_RUN([@%:@include <sys/utsname.h>
int main() { struct utsname unm;
return uname( &unm ); }],
    [ag_cv_run_uname_syscall=yes],[ag_cv_run_uname_syscall=no],[ag_cv_run_uname_syscall=no]
  ) # end of TRY_RUN
  ]) # end of AC_CACHE_VAL for ag_cv_run_uname_syscall
  AC_MSG_RESULT([${ag_cv_run_uname_syscall}])

  if test "X${ag_cv_run_uname_syscall}" != Xno
  then
    AC_DEFINE([HAVE_UNAME_SYSCALL],[1],
        [Define this if uname(2) is POSIX])
  fi
  
]) # end of AC_DEFUN of AG_RUN_UNAME_SYSCALL


AC_DEFUN([AG_COMPILE_LONG_LONG],[
  AC_MSG_CHECKING([whether long long ints])
  AC_CACHE_VAL([ag_cv_compile_long_long],[
  AC_TRY_COMPILE(,[long long i;],
    [ag_cv_compile_long_long=yes],[ag_cv_compile_long_long=no]
  ) # end of TRY_COMPILE
  ]) # end of AC_CACHE_VAL for ag_cv_compile_long_long
  AC_MSG_RESULT([${ag_cv_compile_long_long}])

  if test "X${ag_cv_compile_long_long}" != Xno
  then
    AC_DEFINE([HAVE_LONG_LONG],[1],
        [Define this if long long ints])
  fi
  
]) # end of AC_DEFUN of AG_COMPILE_LONG_LONG


AC_DEFUN([AG_TEST_LDFLAGS],[
  AC_MSG_CHECKING([whether runtime library dirs can be specified])
  AC_CACHE_VAL([ag_cv_test_ldflags],[
    ag_cv_test_ldflags=`exec 2> /dev/null
        echo 'int main() { return 0; }' > conftest.$ac_ext
        libs="${LIBS}"
        LIBS="${LIBS} -Wl,-R/tmp"
        if (eval $ac_link) > /dev/null 2>&1
        then echo '-Wl,-R' ; rm -f conftest* ; exit 0 ; fi
        LIBS="${libs} -R/tmp"
        if (eval $ac_link) > /dev/null 2>&1
        then echo '-R' ; rm -f conftest* ; exit 0 ; fi
        rm -f conftest* ; exit 1`
    if test $? -ne 0
    then ag_cv_test_ldflags=no
    elif test -z "$ag_cv_test_ldflags"
    then ag_cv_test_ldflags=no
    fi
  ]) # end of CACHE_VAL of ag_cv_test_ldflags
  AC_MSG_RESULT([${ag_cv_test_ldflags}])

  if test "X${ag_cv_test_ldflags}" != Xno
  then
    AG_LDFLAGS="@S|@{ag_cv_test_ldflags}"
  else
    AG_LDFLAGS=''
  fi
  AC_SUBST([AG_LDFLAGS])
  
]) # end of AC_DEFUN of AG_TEST_LDFLAGS


AC_DEFUN([AG_ENABLE_DEBUG],[
  AC_ARG_ENABLE([debug],
    AC_HELP_STRING([--enable-debug], [wanting autogen debugging]),
    [ag_cv_enable_debug=${enable_debug}],
    AC_CACHE_CHECK([whether wanting autogen debugging], ag_cv_enable_debug,
      ag_cv_enable_debug=no)
  ) # end of AC_ARG_ENABLE

  if test "X${ag_cv_enable_debug}" != Xno
  then
    AC_DEFINE([DEBUG_ENABLED],[1],
        [Define this if wanting autogen debugging])
    AC_DEFINE([DEBUG_ENABLED], [1],
          [Define this if debugging is enabled])
    CFLAGS="-g `echo $CFLAGS|sed 's%-g *%%g;s%-O[0-9]* *%%g'`"
    f=`which dmalloc 2>/dev/null`
    [ -n "$f" ] && LIBS="${LIBS} -ldmalloc"
  fi
  
]) # end of AC_DEFUN of AG_ENABLE_DEBUG


AC_DEFUN([INVOKE_AG_MACROS],[
  # Check to see if shell scripts are desired.
  AG_DISABLE_SHELL

  # Check to see if using shell scripts.
  AG_TEST_DO_SHELL

  # Check to see if setjmp() links okay.
  AG_LINK_SETJMP

  # Check to see if sigsetjmp() links okay.
  AG_LINK_SIGSETJMP

  # Check to see if a working libguile can be found.
  AG_WITHLIB_GUILE

  # Check to see if the guile version.
  AG_TEST_GUILE_VERSION

  # Check to see if scm_primitive_eval_x links.
  AG_LINK_EVAL_STRING

  # Check to see if a working libxml2 can be found.
  AG_WITHLIB_XML2

  # Check to see if fattach runs.
  AG_RUN_FATTACH

  # Check to see if connld works.
  AG_RUN_CONNLD

  # Check to see if sysinfo(2) is Solaris.
  AG_RUN_SOLARIS_SYSINFO

  # Check to see if strcspn matches prototype and works.
  AG_RUN_STRCSPN

  # Check to see if there is a global text array sys_siglist.
  AG_RUN_SYS_SIGLIST

  # Check to see if uname(2) is POSIX.
  AG_RUN_UNAME_SYSCALL

  # Check to see if long long ints.
  AG_COMPILE_LONG_LONG

  # Check to see if runtime library dirs can be specified.
  AG_TEST_LDFLAGS

  # Check to see if wanting autogen debugging.
  AG_ENABLE_DEBUG

  INVOKE_AG_MACROS_LAST
]) # end AC_DEFUN of INVOKE_AG_MACROS
