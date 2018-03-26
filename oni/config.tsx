
import * as React from "/opt/Oni/resources/app/node_modules/react"
import * as Oni from "/opt/Oni/resources/app/node_modules/oni-api"

export const activate = (oni: Oni.Plugin.Api) => {
    console.log("config activated")

    // Input
    //
    // Add input bindings here:
    //
    oni.input.bind("<c-enter>", () => console.log("Control+Enter was pressed"))

    //
    // Or remove the default bindings here by uncommenting the below line:
    //
    // oni.input.unbind("<c-p>")

}

export const deactivate = (oni: Oni.Plugin.Api) => {
    console.log("config deactivated")
}

export const configuration = {
    //add custom config here, such as

    "ui.colorscheme": "nord",
    "ui.fontFamily": "Fira Sans",
    "ui.fontSize": "16px",
    "tabs.mode": "buffers",
    "recorder.copyScreenshotToClipboard": true,
    "recorder.outputPath": "~/pics/scrots",
    //"oni.useDefaultConfig": true,
    //"oni.bookmarks": ["~/Documents"],
    "oni.loadInitVim": true,
    "editor.fontSize": "18px",
    "editor.fontFamily": "Operator Mono Book",
    "editor.clipboard.enabled": true,

    // UI customizations
    "ui.animations.enabled": true,
    "ui.fontSmoothing": "auto",
}
