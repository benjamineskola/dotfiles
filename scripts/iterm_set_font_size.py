#!/usr/bin/env python
"""Set iterm font size based on window (i.e. screen) size.

Big font on external monitor or large laptop; small font on internal monitor of smaller laptop
"""

import re

import iterm2


async def main(connection):
    """On activation, check window size and set font size of every tab."""
    # This regex splits the font into its name and size. Fonts always end with
    # their size in points, preceded by a space.
    r = re.compile(r"^(.* )(\d*)$")

    app = await iterm2.async_get_app(connection)
    window = app.current_terminal_window

    if window.frame.size.height > 1000:
        size = 16
    else:
        size = 14

    for tab in window.tabs:
        profile = await tab.current_session.async_get_profile()
        font = profile.normal_font
        match = r.search(font)
        if not match:
            continue
        groups = match.groups()
        font_name = groups[0]

        replacement = font_name + str(size)

        await profile.async_set_normal_font(replacement)


iterm2.run_until_complete(main)
