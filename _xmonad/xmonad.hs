import XMonad
import XMonad.Actions.UpdateFocus
import XMonad.Actions.UpdatePointer
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.GridVariants
import XMonad.Layout.PerWorkspace
import XMonad.Prompt
import XMonad.Prompt.Shell
import XMonad.Util.Run(spawnPipe)

import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M


main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ withUrgencyHook NoUrgencyHook
	   $ defaultConfig {
	  modMask = mod4Mask -- Use Super instead of Alt
	, terminal = "urxvt"
	, keys = keymap
	, manageHook = manageDocks <+> manageHook defaultConfig
	, layoutHook = avoidStruts  $  layoutHook defaultConfig
	, startupHook = adjustEventInput
	, handleEventHook = focusOnMouseMove
	, logHook = (dynamicLogWithPP $ xmobarPP
	  { ppOutput = hPutStrLn xmproc
	  , ppTitle = xmobarColor "green" "" . shorten 50
	  , ppUrgent = xmobarColor "red" "" . xmobarStrip
	  })
	  >> updatePointer (Relative 0.99 0.01)
}

ws = ["web", "chat", "3", "4", "5", "6", "7", "todo", "9"]

grid = SplitGrid XMonad.Layout.GridVariants.L 1 1 (1/2) (4/3) (5/100)
layout = onWorkspace "chat" Full $
         (grid ||| Full)

myManageHook = composeAll [ className =? "Firefox"  --> doF (W.shift "web")
		          , title =? "Mail" --> doF (W.shift "chat")
		          , title =? "Work Mail" --> doF (W.shift "chat")
		          , title =? "Home Mail" --> doF (W.shift "chat")
                          , title =? "IRC" --> doF (W.shift "chat")
                          ] <+> manageDocks <+> manageHook defaultConfig

keymap conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ [
      ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- launch a terminal
    , ((modm,               xK_p     ), shellPrompt defaultXPConfig {font="-*-terminus-*-r-*-*-12-*-*-*-*-*-*-*"})
    , ((modm .|. shiftMask, xK_c     ), kill) -- close focused window
    , ((modm,               xK_space ), sendMessage NextLayout) -- Rotate through the available layout algorithms
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf) --  Reset the layouts on the current workspace to default
    , ((modm,               xK_n     ), refresh) -- Resize viewed windows to the correct size
    , ((modm,               xK_Tab   ), windows W.focusDown) -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown) -- Move focus to the next window
    , ((modm,               xK_k     ), windows W.focusUp  ) -- Move focus to the previous window
    , ((modm,               xK_m     ), windows W.focusMaster  ) -- Move focus to the master window
    , ((modm,               xK_Return), windows W.swapMaster) -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  ) -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    ) -- Swap the focused window with the previous window
    , ((modm,               xK_h     ), sendMessage Shrink) -- Shrink the master area
    , ((modm,               xK_l     ), sendMessage Expand) -- Expand the master area
    , ((modm,               xK_t     ), withFocused $ windows . W.sink) -- Push window back into tiling
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1)) -- Increment the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1))) -- Deincrement the number of windows in the master area

    , ((modm .|. shiftMask, xK_equal), sendMessage $ IncMasterCols 1)
    , ((modm .|. shiftMask, xK_minus), sendMessage $ IncMasterCols (-1))
    , ((modm .|. controlMask,  xK_equal), sendMessage $ IncMasterRows 1)
    , ((modm .|. controlMask,  xK_minus), sendMessage $ IncMasterRows (-1))

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- Quit xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart") -- Restart xmonad

    , ((0, xK_Print), spawn "scrot")
    , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
    , ((0, 0xff14), spawn "xscreensaver-command --lock")
    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

