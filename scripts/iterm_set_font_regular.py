#!/usr/bin/env python
import iterm2


async def main(connection):
    profiles = await iterm2.PartialProfile.async_query(connection)
    for partial in profiles:
        profile = await partial.async_get_full_profile()
        await profile.async_set_normal_font(
            profile.normal_font.replace("Light", "Regular")
        )


iterm2.run_until_complete(main)
