import QtQuick

// The dock is a service plugin, but Omarchy only hands out the shell's app
// library (and therefore the icons in the app grid) to plugins that also
// declare the "menu" kind. This stub satisfies that requirement without
// registering any visible menu: nothing ever summons it.
Item {
}
