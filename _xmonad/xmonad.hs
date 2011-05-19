import XMonad
import XMonad.Layout.IndependentScreens
import XMonad.Hooks.UrgencyHook

import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main = do
	xmonad $ uh "1" $ uh "2" $ defaultConfig
		{ modMask = mod4Mask -- Use Super instead of Alt
		, terminal = "urxvtc"
		, workspaces = map show ([1..9]++[0])
		, keys = newKeys
		, manageHook = myManageHook
		} where

defKeys    = keys defaultConfig
delKeys x  = foldr M.delete           (defKeys x) (toRemove x)
newKeys x  = foldr (uncurry M.insert) (delKeys x) (toAdd    x)
toRemove XConfig{modMask = modm} = [
	(modm .|. shiftMask, xK_p     )
	]
toAdd XConfig{modMask = modm} = []

myManageHook = composeAll
	[ className =? "MPlayer"	--> doFloat
	, className =? "Xmessage"	--> doFloat
	, title =? "IRC"	--> doF (W.shift chat)
	, title =? "Mail"	--> doF (W.shift mail)
	, title =? "News"	--> doF (W.shift mail)
	, title =? "XMPP"	--> doF (W.shift chat)
	, title =? "identi.ca"	--> doF (W.shift twit)
	, title =? "twitter"	--> doF (W.shift twit)
	, className =? "luakit"	--> doF (W.shift web)
	, className =? "Www"	--> doF (W.shift web)
	, className =? "Chrome"	--> doF (W.shift web)
	, className =? "Firefox"	--> doF (W.shift web)
	, resource =? "spotify.exe"	--> doF (W.shift music)
	, resource =? "explorer.exe"	--> doF (W.shift music)
	] where
		web = "1"
		mail = "2"
		chat = mail
		twit = "9"
		music = "0"

uh n = withUrgencyHookC dzenUrgencyHook { args = ["-bg", "darkred", "-xs", n, "-w", "200"] } urgencyConfig { remindWhen = Every 5 }
