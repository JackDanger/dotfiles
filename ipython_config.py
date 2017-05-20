from IPython.terminal.interactiveshell import TerminalInteractiveShell
from IPython.core.magic import register_line_magic

TerminalInteractiveShell.confirm_exit = False


@register_line_magic
def whereami(line):
    import traceback
    for stack_frame in traceback.extract_stack():
        if stack_frame[3] == 'from IPython.terminal.embed import embed; embed()':  # NOQA
            line = stack_frame[1]
            file = stack_frame[0]
            break
    if not line:
        raise Exception("couldn't figure out the line number")
    import linecache
    linecache.updatecache(file, None)

    print(file)
    for n in range(line - 10, line + 10):
        if n == line:
            prefix = '{}: =>'.format(n)
        else:
            prefix = '{}:   '.format(n)
        print(prefix + linecache.getline(file, n).replace('\n', ''))
