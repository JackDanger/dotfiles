from IPython.terminal.interactiveshell import TerminalInteractiveShell

TerminalInteractiveShell.confirm_exit = False

c = get_config()
try:
    import line_profiler
    c.TerminalIPythonApp.extensions = [
        'line_profiler',
    ]
except Exception:
    pass
