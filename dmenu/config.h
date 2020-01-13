static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Roboto Mono:style=Medium:size=14"
};
static int centered = 1;
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static unsigned int lineheight = 35;
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#cbd6e2", "#121212" },
	[SchemeSel] = { "#121212", "#cbd6e2" },
	[SchemeOut] = { "#000000", "#00ffff" },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 5;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
