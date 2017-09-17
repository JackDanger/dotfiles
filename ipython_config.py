from IPython.terminal.interactiveshell import TerminalInteractiveShell

TerminalInteractiveShell.confirm_exit = False

c = get_config()
c.TerminalIPythonApp.extensions = [
    'line_profiler',
]
