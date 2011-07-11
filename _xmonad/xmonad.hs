import XMonad

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.IM
import XMonad.Layout.GridVariants
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.Reflect
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run (spawnPipe)

import Data.Ratio ((%))
import System.Exit
import System.IO
import System.Posix.Unistd (getSystemID, nodeName)

import qualified Data.Map        as M
import qualified XMonad.StackSet as W

main = do
	host <- fmap nodeName getSystemID
	let width = if host == "goldman" then "640" else "960"
	d <- spawnPipe ("dzen2 -w " ++ width ++ " -ta l")
	spawn ("status | dzen2 -w "++width++" -x "++width++" -ta r")
	xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
		{ modMask = mod4Mask -- Use Super instead of Alt
		, terminal = "urxvtc"
		, workspaces = map show ([1..9]++[0])
		, keys = newKeys
		, manageHook = myManageHook <+> manageDocks
		, logHook = myLogHook d
		, layoutHook = avoidStruts $ (tall ||| wide ||| noBorders Full ||| cssh)
		, normalBorderColor  = "#303030"
		, focusedBorderColor = "#909090"
		} where

cssh = named "Cssh" $ reflectVert $ Mirror $ withIM (1%10) (ClassName "Cssh") $ Grid (4/3)
tall = smartBorders $ Tall 1 (3/100) (1/2)
wide = named "Wide" $ Mirror tall

defKeys    = keys defaultConfig
delKeys x  = foldr M.delete           (defKeys x) (toRemove x)
newKeys x  = foldr (uncurry M.insert) (delKeys x) (toAdd    x)
toRemove XConfig{modMask = modm} = [
	(modm .|. shiftMask, xK_p     )
	, (modm, xK_p     )
	]
toAdd conf@(XConfig {XMonad.modMask = modm}) = [
	((m .|. modm, k), windows $ f i)
	| (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
	, (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]] ++
	[
	  ((modm .|. shiftMask, xK_equal), sendMessage $ IncMasterCols 1)
	, ((modm .|. shiftMask, xK_minus), sendMessage $ IncMasterCols (-1))
	, ((modm .|. controlMask,  xK_equal), sendMessage $ IncMasterRows 1)
	, ((modm .|. controlMask,  xK_minus), sendMessage $ IncMasterRows (-1))

	, ((modm, xK_r), shellPrompt defaultXPConfig)
	]

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
	, className =? "Chromium"	--> doF (W.shift web)
	, className =? "Firefox"	--> doF (W.shift web)
	, className =? "Iceweasel"	--> doF (W.shift web)
	, resource =? "spotify.exe"	--> doF (W.shift music)
	, resource =? "explorer.exe"	--> doF (W.shift music)
	] where
		web = "1"
		mail = "2"
		chat = mail
		twit = "9"
		music = "0"

myLogHook h = dynamicLogWithPP $ defaultPP
    { ppCurrent         = dzenColor "#303030" "#909090" . pad
    , ppHidden          = dzenColor "#909090" "" . pad
    , ppHiddenNoWindows = dzenColor "#606060" "" . pad
    , ppLayout          = dzenColor "#909090" ""
    , ppUrgent          = dzenColor "#000000" "#ff0000" . dzenStrip
    , ppTitle           = shorten 100 . pad
    , ppWsSep           = ""
    , ppSep             = " "
    , ppOutput          = hPutStrLn h
    }
