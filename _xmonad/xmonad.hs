import XMonad
import XMonad.Layout.IndependentScreens
import XMonad.Hooks.UrgencyHook

import System.Exit
import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main = do
	nScreens <- countScreens
	xmonad $ uh "1" $ uh "2" $ defaultConfig
		{ modMask = mod4Mask -- Use Super instead of Alt
		, terminal = "urxvtc"
		, workspaces = withScreens nScreens (map show ([1..9]++[0]))
		, keys = newKeys
		, manageHook = getManageHook nScreens
		} where

defKeys    = keys defaultConfig
delKeys x  = foldr M.delete           (defKeys x) (toRemove x)
newKeys x  = foldr (uncurry M.insert) (delKeys x) (toAdd    x)
toRemove XConfig{modMask = modm} = [
	(modm .|. shiftMask, xK_p     )
	]
toAdd conf@(XConfig {XMonad.modMask = modm}) =
    [((m .|. modm, k), windows $ onCurrentScreen f i)
     | (i, k) <- zip (workspaces' conf) ([xK_1 .. xK_9] ++ [xK_0])
     , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

getManageHook n = composeAll
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
		mail = if n == 2 then "1_1" else "0_2"
		chat = mail
		twit = "0_9"
		web = "0_1"
		music = "0_0"

uh n = withUrgencyHookC dzenUrgencyHook { args = ["-bg", "darkred", "-xs", n, "-w", "200"] } urgencyConfig { remindWhen = Every 5 }
