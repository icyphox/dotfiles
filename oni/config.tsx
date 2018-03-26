import * as React from "/opt/Oni/resources/app/node_modules/react"
import * as Oni from "/opt/Oni/resources/app/node_modules/oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))
}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    "ui.colorscheme": "onedark",
    "ui.fontFamily": "Fira Sans",
    "ui.fontSize": "16px",
    "tabs.mode": "buffer",
    "tabs.enabled": true,
    "recorder.copyScreenshotToClipboard": true,
    "recorder.outputPath": "~/pics/scrots",
    "language.python.languageServer.command": "pyls",
    "oni.loadInitVim": true,
    "oni.useDefaultConfig": true,
    "oni.hideMenu": true,
    "editor.fontSize": "20px",
    "editor.fontFamily": "Operator Mono Book",
    "editor.clipboard.enabled": true,
    "oni.useExternalPopupMenu": true,
    "autoClosingPairs.enabled": true,
    // UI customizations
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
}
