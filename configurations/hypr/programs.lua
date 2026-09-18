---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
terminal      = "alacritty"
fileManager   = "dolphin"
menu          = "rofi -show drun"
browser       = "helium-browser"
main_browser  = "zen-twilight"
game_launcher = "steam"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
hl.on("hyprland.start", function()
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3'")
end)
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
