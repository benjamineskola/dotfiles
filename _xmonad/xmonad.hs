import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)

import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M


main = do
    xmproc <- spawnPipe "xmobar"
    xmonad defaultConfig {
	  modMask = mod4Mask -- Use Super instead of Alt
	, terminal = "urxvtc"
	, keys = keymap
	, manageHook = manageDocks <+> manageHook defaultConfig
	, layoutHook = avoidStruts  $  layoutHook defaultConfig
	, logHook = dynamicLogWithPP $ xmobarPP
	  { ppOutput = hPutStrLn xmproc
	  , ppTitle = xmobarColor "green" "" . shorten 50
	  }
}

keymap conf@(XConfig {XMonad.modMask = modm}) = M.fromList $ [
      ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf) -- launch a terminal
    , ((modm,               xK_p     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\"") -- launch dmenu
    , ((modm .|. shiftMask, xK_p     ), spawn "gmrun") -- launch gmrun
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
 
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
 
    , ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess)) -- Quit xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart") -- Restart xmonad
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
        | (key, sc) <- zip [xK_e, xK_w, xK_r] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

