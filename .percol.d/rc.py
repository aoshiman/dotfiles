# X / _ / X
percol.view.PROMPT  = ur"<bold><yellow>X / _ / X</yellow></bold> %q"

# Vim like
percol.import_keymap({
    "C-n" : lambda percol: percol.command.select_next(),
    "C-p" : lambda percol: percol.command.select_previous(),
    "C-f" : lambda percol: percol.command.select_next_page(),
    "C-b" : lambda percol: percol.command.select_previous_page(),
    "C-m" : lambda percol: percol.finish(),
    "q" : lambda percol: percol.cancel(),
    })
